#include <LiquidCrystal.h>

// LCD pins: RS, E, D4, D5, D6, D7
LiquidCrystal lcd(21, 22, 18, 19, 23, 5);

// Ultrasonic sensor pins
#define TRIG_PIN 4
#define ECHO_PIN 16
#define LED_PIN 32

// Measurement parameters
const float SOUND_SPEED = 0.034; // cm/μs
const float MIN_DISTANCE = 10.00;  // cm
const float MAX_DISTANCE = 15.00;  // cm

#define MEDIAN_FILTER_SIZE 5
float distanceBuffer[MEDIAN_FILTER_SIZE];
byte bufferIndex = 0;
const float SMOOTHING_FACTOR = 0.7;
float smoothedDistance = 0;
float lastValidDistance = 0;

const int DEBOUNCE_COUNT = 3;
int debounceCounter = 0;
unsigned long startTime = 0;
unsigned long stopTime = 0;
bool timing = false;
bool finished = false;
bool gracePeriod = true;
unsigned long graceStartTime = 0;
const unsigned long GRACE_PERIOD = 10000;

const float D1 = 13.84;
const float D2 = 11.835;

const float A_FAST = 0.2447656223;
const float B_FAST = 0.06153034765;
const float A_SLOW = 1.297738228;
const float B_SLOW = -235.6160549;
const float TIME_THRESHOLD = 10.0;

void setup() {
  Serial.begin(115200);
  pinMode(TRIG_PIN, OUTPUT);
  pinMode(ECHO_PIN, INPUT);
  pinMode(LED_PIN, OUTPUT);

  lcd.begin(16, 2);
  lcd.print("Initializing...");

  for (byte i = 0; i < MEDIAN_FILTER_SIZE; i++) {
    distanceBuffer[i] = getRawDistance();
    delay(50);
  }

  lastValidDistance = medianOfArray(distanceBuffer, MEDIAN_FILTER_SIZE);
  smoothedDistance = lastValidDistance;

  graceStartTime = millis();
  updateDisplay();
  Serial.println("System Ready - Enhanced Stability Active");
}

void loop() {
  if (finished) {
    delay(1000);
    return;
  }

  float currentDistance = getFilteredDistance();
  updateDisplay();

  Serial.print("Filtered: ");
  Serial.print(currentDistance, 2);
  Serial.print("cm | Grace: ");
  Serial.println(gracePeriod ? "Yes" : "No");

  if (gracePeriod && (millis() - graceStartTime > GRACE_PERIOD)) {
    gracePeriod = false;
    lcd.setCursor(0, 1);
    lcd.print("Ready to measure ");
    Serial.println("Grace Period Ended");
  }

  if (!gracePeriod && !timing) {
    checkMeasurementStart(currentDistance);
  }

  if (timing && currentDistance < D2) {
    stopMeasurement();
  }

  delay(100);
}

void checkMeasurementStart(float currentDistance) {
  if (currentDistance < D1 && currentDistance > D2) {
    debounceCounter++;
    if (debounceCounter >= DEBOUNCE_COUNT) {
      startTime = millis();
      timing = true;
      digitalWrite(LED_PIN, HIGH);
      lcd.setCursor(0, 1);
      lcd.print("Measuring...    ");
      Serial.println("Measurement Started - Valid Trigger");
      debounceCounter = 0;
    }
  } else {
    debounceCounter = 0;
  }
}

void stopMeasurement() {
  stopTime = millis();
  float seconds = (stopTime - startTime) / 1000.0;

  float viscosity;
  if (seconds < TIME_THRESHOLD) {
    viscosity = A_FAST * seconds - B_FAST / seconds;
    Serial.print("Used fast flow constants | ");
  } else {
    viscosity = A_SLOW * seconds - B_SLOW / seconds;
    Serial.print("Used slow flow constants | ");
  }

  showFinalResults(seconds, viscosity);
  digitalWrite(LED_PIN, LOW);
  finished = true;
}



float getRawDistance() {
  digitalWrite(TRIG_PIN, LOW);
  delayMicroseconds(2);
  digitalWrite(TRIG_PIN, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIG_PIN, LOW);

  long duration = pulseIn(ECHO_PIN, HIGH, 30000); // Timeout added
  float distance = duration * SOUND_SPEED / 2;

  if (distance < MIN_DISTANCE || distance > MAX_DISTANCE || duration == 0) {
    return lastValidDistance;
  }

  return distance;
}

float medianOfArray(float arr[], byte size) {
  float sorted[size];
  memcpy(sorted, arr, size * sizeof(float));

  for (byte i = 0; i < size - 1; i++) {
    for (byte j = i + 1; j < size; j++) {
      if (sorted[j] < sorted[i]) {
        float temp = sorted[i];
        sorted[i] = sorted[j];
        sorted[j] = temp;
      }
    }
  }

  if (size % 2 == 0) {
    return (sorted[size/2 - 1] + sorted[size/2]) / 2;
  } else {
    return sorted[size/2];
  }
}

float getFilteredDistance() {
  float newReading = getRawDistance();

  distanceBuffer[bufferIndex] = newReading;
  bufferIndex = (bufferIndex + 1) % MEDIAN_FILTER_SIZE;

  float median = medianOfArray(distanceBuffer, MEDIAN_FILTER_SIZE);
  smoothedDistance = SMOOTHING_FACTOR * median + (1.0 - SMOOTHING_FACTOR) * smoothedDistance;

  lastValidDistance = smoothedDistance;
  return smoothedDistance;
}

void updateDisplay() {
  lcd.setCursor(0, 0);
  lcd.print("Dist: ");
  lcd.print(smoothedDistance, 1);
  lcd.print(" cm    ");
}

void showFinalResults(float seconds, float viscosity) {
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("Time: ");
  lcd.print(seconds, 2);
  lcd.print("s");

  lcd.setCursor(0, 1);
  lcd.print("Visc: ");
  lcd.print(viscosity, 2);
  lcd.print(" cSt");

  Serial.print("Time: ");
  Serial.print(seconds, 2);
  Serial.print("s | Viscosity: ");
  Serial.print(viscosity, 2);
  Serial.println(" cSt");
}
