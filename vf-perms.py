import os
from subprocess import Popen,PIPE

print("Name of directory in /usr/share/games to grant user access to?")
given_dir = input()

output = Popen(["whoami"],stdout=PIPE)
result = output.communicate()
current_user = result[0].decode("utf-8").split()[0]
print(current_user)

if os.path.exists("/usr/share/games/" + given_dir):
    print("Granting ownership.")
    print("sudo chown -R " + current_user + " /usr/share/games/" + given_dir)
    os.system("sudo chown -R " + current_user + " /usr/share/games/" + given_dir)
else:
    raise NotADirectoryError("Could not find " + given_dir + ". Did you spell it correctly, or have you not installed the game/mod yet? Some ebuilds also use alternate directory names, so try using ls on /usr/share/games.")

print("You should now own the folder.")
