import sys
import os

if __name__ == "__main__":

    numOfArguments = len(sys.argv)
    args = sys.argv.copy()
    args.pop(0)

    for i in range(len(args)):
        if args[i] == "-h":
            print("Options:\n"
                  "-h Prints this help\n"
                  "-i Sets the project name\n")
            continue
        if args[i] == "-i":
            os.mkdir(args[i+1])
            print("New project created:\n",
                  args[i+1])
            os.chdir(args[i+1])
            os.mkdir("src")
            file = open("src/main.cpp", "w")
            file.close()
            file = open("README.md", "w")
            file.close()
            file = open("src/makefile", "w")
            file.write("CFLAGS = ''\nLIBS = '' \n")
            file.write("% : %.cpp\n\t"
                       "g++ $(CFLAGS) $(LIBS) -o $@ $<\n\n"
                       "clean:\n\t"
                       "@echo \"Deleting...\"\n\t"
                       "@rm main")
            file.close()
            file = open("src/.clangd", "w")
            file.write("CompileFlags:\tAdd: [-std=c++23]")
            file.close()
            continue
