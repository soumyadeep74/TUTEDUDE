student = {}

def add_student(name, grade):
    if name in student:
        print("Student already exists.")
    else:
        student[name] = grade
        print(f"Student {name} with grade {grade} added successfully.")

def update_student(name,grade):
    if name in student:
        student[name] = grade
        print(f"Student {name} with grade {grade} updated successfully.")
    else:
        print("Student not found.")

def print_student():
    if student:
        print("Student List:")
        for name, grade in student.items():
            print(f"{name}:{grade}")
    else:
        print("No students found.")

while True:
    print("\nChoose an option:\n")
    print("1. Add Student")
    print("2. Update Student")
    print("3. Print Students")
    print("4. Exit")

    choice = input("Enter your choice (1-4): ")

    if choice == '1':
        name = input("Enter student name: ")
        grade = input("Enter student grade: ")
        add_student(name, grade)
        
    elif choice == '2':
        name = input("Enter student name to update: ")
        grade = input("Enter new grade: ")
        update_student(name, grade)
        
    elif choice == '3':
        print_student()
        
    elif choice == '4':
        print("Exiting...")
        break
    else:
        print("Invalid choice. Please try again.")
        