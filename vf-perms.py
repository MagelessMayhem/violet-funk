import os

print("Name of directory in /usr/share/games to grant user access to?")
given_dir = input()

print(os.system("whoami"))

if os.path.exists("/usr/share/games/" + given_dir):
    os.system("sudo chown $(whoami) /usr/share/games/" + given_dir + "/*")

print("You should now own the folder.")
