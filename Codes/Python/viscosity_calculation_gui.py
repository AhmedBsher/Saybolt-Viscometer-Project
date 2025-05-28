import tkinter as tk
from tkinter import messagebox, ttk

A_FAST = 0.2447656223  # Coefficient for t < 10s
B_FAST = 0.06153034765  # Coefficient for t < 10s
A_SLOW = 1.297738228    # Coefficient for t >= 10s
B_SLOW = -235.6160549   # Coefficient for t >= 10s
TIME_THRESHOLD = 10.0   # Time threshold in seconds
MIN_TIME = 0.1          # Minimum valid time (seconds)
MAX_TIME = 100.0        # Maximum valid time (seconds)

# Function to calculate viscosity and update the output
def calculate_viscosity():
    try:
        t = float(time_entry.get())
        
        if t <= 0:
            messagebox.showerror("Error", "Please enter a valid positive number!")
            return
        
        if t < MIN_TIME or t > MAX_TIME:
            messagebox.showerror("Error", "Time must be between 0.1 and 100 seconds!")
            return
        
        if t < TIME_THRESHOLD:
            viscosity = A_FAST * t - B_FAST / t
            equation = "Fast flow equation (t < 10s)"
        else:
            viscosity = A_SLOW * t - B_SLOW / t
            equation = "Slow flow equation (t >= 10s)"
        
        output_text.config(state='normal')  # Enable editing
        output_text.delete(1.0, tk.END)  # Clear previous content
        output_text.insert(tk.END, f"Time: {t:.2f} seconds\n")
        output_text.insert(tk.END, f"Viscosity: {viscosity:.4f} cSt\n")
        output_text.insert(tk.END, f"Equation: {equation}\n")
        output_text.config(state='disabled')  # Make it read-only again
    
    except ValueError:
        messagebox.showerror("Error", "Please enter a valid number!")

def clear_fields():
    time_entry.delete(0, tk.END)
    time_entry.insert(0, "5") 
    output_text.config(state='normal')
    output_text.delete(1.0, tk.END)
    output_text.insert(tk.END, "Enter a time and click Calculate\n")
    output_text.config(state='disabled')

root = tk.Tk()
root.title("Viscosity Calculator")
root.geometry("450x350")  
root.configure(bg="#f0f0f0")  

input_frame = ttk.Frame(root, padding="10")
input_frame.pack(pady=20)

input_label = ttk.Label(input_frame, text="Enter Time (seconds):", font=("Arial", 12))
input_label.grid(row=0, column=0, padx=5, pady=5)

time_entry = ttk.Entry(input_frame, width=15)
time_entry.insert(0, "5")  # Default value
time_entry.grid(row=0, column=1, padx=5, pady=5)

calc_button = ttk.Button(input_frame, text="Calculate", command=calculate_viscosity)
calc_button.grid(row=1, column=0, padx=5, pady=5)

clear_button = ttk.Button(input_frame, text="Clear", command=clear_fields)
clear_button.grid(row=1, column=1, padx=5, pady=5)

output_text = tk.Text(root, height=10, width=50, bg="#ffffff", font=("Arial", 10))
output_text.pack(pady=20, padx=10)
output_text.insert(tk.END, "Enter a time and click Calculate\n")
output_text.config(state='disabled')

root.mainloop()