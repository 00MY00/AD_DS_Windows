# <span style="color: #046ed1">AD_DS_Windows </span>
<br> </br>

# <span style="color: #2dbf0f">Description : </span>
* Permet d'ajouter plusieurs Group et utilisateur a un Active Directory Windows Serveur 
----
# Comment Installer et utiliser le Script PowerShell avec ‘Git’ sur PowerShell.
* 1)	Ouvré un terminale PowerShell en ‘Administrateur’
* 2)	Entrez la commande -> Set-ExecutionPolicy Unrestricted
* 3)	Entrez la commande -> Git clone  https://github.com/00MY00/AD_DS_Windows.git & cd ./AD_DS_Windows/ & ./NewaddUsers.ps1
----
# Comment Installer et utiliser le Script PowerShell avec ‘Git’ sur CMD.
* 1)	Ouvré un terminale CMD en ‘Administrateur’
* 2)	Entrez la command -> powershell -command “&{Set-ExecutionPolicy Unrestricted}”
* 3)	Entrez la command -> Git clone  https://github.com/00MY00/AD_DS_Windows.git & cd ./AD_DS_Windows/ & powershell.exe ./NewaddUsers.ps1
----
# Comment Installer et utiliser le Script PowerShell sur CMD ou PowerShell.
* 1)	Ouvré un terminale CMD ou Powershell en ‘Administrateur’
* 2)	Entez la command -> cd %USERPROFILE% & mkdir AD_DS_Windows & cd ./AD_DS_Windows & curl -o NewaddUsers.ps1 https://raw.githubusercontent.com/00MY00/AD_DS_Windows/main/NewaddUsers.ps1 && ./NewaddUsers.ps1

Execution du script:
* 3)	CMD 		-> powershell.exe ./NewaddUsers.ps1
* 3)	PowerShell 	-> ./NewaddUsers.ps1

# <span style="color: #d10404">Help </span>
* 1)  Si vous rencontrée des problème vérifier que vous autoriser l’exécution de script -> ‘Set-ExecutionPolicy Unrestricted’
* 2)  Vérifier dans le rapport les messages d'erreur.


# <span style="color: #d14204">Utilisation : </span>
* - Crée un fichier Users.CSV 
* - La première ligne et importante et ne dois pas être changée elle représente les entête 
* - Selon votre nom de domaine changer les 'DC='

# <span style="color: #d17504">Example : </span>
* LastName,FirstName,UserName,Password,OrganizationalUnit
* "Nom_de_Famil","Prenom","Nom_D_Utilisateur","Mot_De_pass", "OU=Unité_d_organisation,DC=Mon,DC=domaine,DC=local"
<br> </br>

----
# <span style="color: #2dcf9c">Auteur : Kuroakashiro & Denis </span>


PS : Je m’excuse pour les fautes d’orthographe venant de ma forte dyslexie mais je me concentre plus sur le Scripting que l’orthographe.
----
