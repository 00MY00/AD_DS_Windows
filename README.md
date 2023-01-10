# AD_DS_Windows
# Description : Permet d'ajouter plusieurs Group et utilisateur a un Active Directory Windows Serveur 
# ##################################################### #
# -------------------------------------------------------------------------
# Comment Installer et utiliser le Script PowerShell avec ‘Git’ sur PowerShell.
1)	Ouvré un terminale PowerShell en ‘Administrateur’
2)	Entrez la commande -> Set-ExecutionPolicy Unrestricted
3)	Entrez la commande -> Git clone  https://github.com/00MY00/AD_DS_Windows.git & cd ./AD_DS_Windows/ & ./NewaddUsers.ps1
# -------------------------------------------------------------------------
# Comment Installer et utiliser le Script PowerShell avec ‘Git’ sur CMD.
1)	Ouvré un terminale CMD en ‘Administrateur’
2)	Entrez la command -> powershell -command “&{Set-ExecutionPolicy Unrestricted}”
3)	Entrez la command -> Git clone  https://github.com/00MY00/AD_DS_Windows.git & cd ./AD_DS_Windows/ & powershell.exe ./NewaddUsers.ps1
# -------------------------------------------------------------------------
# Comment Installer et utiliser le Script PowerShell sur CMD ou PowerShell.
1)	Ouvré un terminale CMD ou Powershell en ‘Administrateur’
2)	Entez la command -> cd %USERPROFILE% & mkdir AD_DS_Windows & cd ./AD_DS_Windows & curl -o NewaddUsers.ps1 https://raw.githubusercontent.com/00MY00/AD_DS_Windows/main/NewaddUsers.ps1 & powershell.exe ./NewaddUsers.ps1

# Helpe
Si vous rencontrée des problème vérifier que vous autoriser l’exécution de script -> ‘Set-ExecutionPolicy Unrestricted’

# ============================== #
# Auteur : Denis & Kuroakashiro  #
# ============================== #
