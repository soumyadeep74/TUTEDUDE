file_name = "test_file.txt"

f = open(file_name, "w")
f.write("This is a test file.\n")
f.write("adding new line \n")
f.close()

f = open(file_name, "r")
data = f.read()
print(data)
f.close()
