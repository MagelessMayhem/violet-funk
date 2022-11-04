import os

print("Name of directory in /usr/share/games to grant user access to?")
given_dir = input()

current_user = os.system("whoami")

if os.path.exists("/usr/share/games/" + given_dir):
    print("Granting ownership.")
    os.system("sudo chown " + current_user + " /usr/share/games/" + given_dir + "/*")

print("You should now own the folder.")
