import os
from subprocess import Popen,PIPE
print("Name of directory in /usr/share/games to grant user access to?")
given_dir = input()
output = Popen(["whoami"],stdout=PIPE)
result = output.communicate()
print(result[0].decode("utf-8"))
current_user = result.index('wizard\n').split()
if os.path.exists("/usr/share/games/" + given_dir):
    print("Granting ownership.")
    os.system("sudo chown " + current_user + " /usr/share/games/" + given_dir + "/*")

print("You should now own the folder.")
