################################################
#            Auteur Denis                      #
################################################
#                                              #
# Le script permet d'ajouter des utilisateur   #
# a un active directori.                       #
#                                              #
# Il a été crée dans le cadre d'un cours       #
#                                              #
# Des amelioration on été aporter par          #
# Kuroakashiro pour le style et la simplicitée #
# d'utilisation du script                      #
################################################

# Version 1.2

# Importation du Module Active Directory
Import-Module ActiveDirectory

# Affichage de txt en UTF8
chcp 65001
# Changement de la tail de fenêtre
mode con cols=80 lines=15
# Changement du titre pour conaitre l'étape actuelle du script
$host.ui.RawUI.WindowTitle = “Verification Du fonctionement de AD”

# test d'existance de dossier de raport et reation
$Errorlevel = Test-Path -Path "$PWD\Rapport"
if ( $Errorlevel -eq $True)
{
    
    # Crée le nom du Fichier Rapport avec l'aide de la date
    $y = date
    $y = "$y"
    $x = date
    $x = "$x"
    $x = $x -replace(' ', '_')
    $x = $x -replace('/', '_')
    # Change les ':' de l'heur par 'H' et 'M'
    For ([int]$i = 1; $i -lt 3; [int]$i++)
    {
    if ( $i -eq 1 ) {$st = "H"} else {$st = "M"}
    $index = $x.IndexOf(":")
    $x = $x.Substring(0, $index) + "$st" + $x.Substring($index + $i)
    }
    # Concatenation pour crée le nom du fichier
    $Raport = "Raport_AD_DS_" + "$x" + ".txt"

    "##########################" > "$PWD\Rapport\$Raport"
    "#   Raport d'execution   #" >> "$PWD\Rapport\$Raport"
    "# Du script :NewaddUsers #" >> "$PWD\Rapport\$Raport"
    "##########################" >> "$PWD\Rapport\$Raport"
    "# Executée le : $y" >> "$PWD\Rapport\$Raport"
    "##########################" >> "$PWD\Rapport\$Raport"
    " " >> "$PWD\Rapport\$Raport"


    # Verifit ci trop de Rapport exist informe l'utilisateur
    $NbDeRapport = (Get-ChildItem -Path "$PWD\Rapport" -File).Count
    [int]$NbDeRapport = [int]$NbDeRapport
    if ( [int]$NbDeRapport -gt 20 )
    {
        Clear
        Write-Host ""
        Write-Host ""
        Write-Host "[ Atention ]"  -ForegroundColor Yellow -NoNewline
        Write-Host "Il y a plus de 20 Rapport pensée a les suprimée !"
        Write-Host "Dans '$PWD\Rapport'"
        "[ ATENTION ] Il y a plus de 20 Rapports pensez a les suprimées !" >> "$PWD\Rapport\$Raport"
        Write-Host ""
        Write-Host ""
        Start-Sleep 5
        # Changement de la tail de fenêtre
        mode con cols=40 lines=15
    }


}
else {
    # Maime action que en le if mais crée le chemain ci nesesaire
    mkdir "$PWD\Rapport"

    $y = date
    $y = "$y"
    $x = date
    $x = "$x"
    $x = $x -replace(' ', '_')
    $x = $x -replace('/', '_')

    For ([int]$i = 1; $i -lt 3; [int]$i++)
    {
    if ( $i -eq 1 ) {$st = "H"} else {$st = "M"}
    $index = $x.IndexOf(":")
    $x = $x.Substring(0, $index) + "$st" + $x.Substring($index + $i)
    }

    $Raport = "Raport_AD_DS_" + "$x" + ".txt"
    "##########################" > "$PWD\Rapport\$Raport"
    "#   Raport d'execution   #" >> "$PWD\Rapport\$Raport"
    "# Du script :NewaddUsers #" >> "$PWD\Rapport\$Raport"
    "##########################" >> "$PWD\Rapport\$Raport"
    "# Executée le : $y" >> "$PWD\Rapport\$Raport"
    "##########################" >> "$PWD\Rapport\$Raport"
    " " >> "$PWD\Rapport\$Raport"
}

# Variable Style
$BarreDuAu = "╔═══════════════════════════════════════════╗"
$BarreDuBa = "╚═══════════════════════════════════════════╝"
$BarreGros = "▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓"
$BarreFine = "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"

# STR Variables
$StrClearTemp = "Le Fichier temporaire est bien suprimée"
$StrCSVDefinit = "Fichier selectioné '$MonCSV'"
$StrChoiDuCSV = "Plusieur entrée touvée`nChoisiser le fichier a utilisée `nEn entrant le chemin absolut !"
$StrFichierExist = "Le Fichier existe"
$StrFichierExistPas = "Le fichier exist mais n'est pas valide !"
$StrFichierImporter = "le fichier et Chargé !"

# STR Variables d'Erreur
$StrCSVDefinit = "Une erreur est survenue 0 ligne dans le fichier"
$StrErreurImportFichier = "Une Erreur est survenu lord de l'importation !"
$StrErreurEntrerIncorect = "`n `nEntée incorecte !!"
$StrFichierIntrouvabl = "Aucun fichier trouvés ! `nLe fichier doi s'apeler 'Users*.csv'"
$StrNoAD = "Une erreur est survenu avec l'AD. `nVerifier que l'Active Directory soit bien instalée et confugurée"

# Variavles location
$location = $PWD

# ACSII Images
$charge0 = "
     □■
    □□□■
   □□□□□■
  ■□□□□□□■
   ■□□□□■
    ■□□■
     ■■
"
$charge1 = "
     □□
    □□□■
   ■□□□□■
  ■□□□□□□■
   ■□□□□■
    ■□□■
     ■■
"
$charge2 = "
     □□
    ■□□□
   ■□□□□■
  ■□□□□□□■
   ■□□□□■
    ■□□■
     ■■
"
$charge3 = "
     ■□
    ■□□□
   ■□□□□□
  ■□□□□□□■
   ■□□□□■
    ■□□■
     ■■
"
$charge4 = "
     ■■
    ■□□□
   ■□□□□□
  ■□□□□□□□
   ■□□□□■
    ■□□■
     ■■
"
$charge5 = "
     ■■
    ■□□■
   ■□□□□□
  ■□□□□□□□
   ■□□□□□
    ■□□■
     ■■
"
$charge6 = "
     ■■
    ■□□■
   ■□□□□■
  ■□□□□□□□
   ■□□□□□
    ■□□□
     ■■
"
$charge7 = "
     ■■
    ■□□■
   ■□□□□■
  ■□□□□□□■
   ■□□□□□
    ■□□□
     ■□
"
$charge8 = "
     ■■
    ■□□■
   ■□□□□■
  ■□□□□□□■
   ■□□□□■
    ■□□□
     □□
"
$charge9 = "
     ■■
    ■□□■
   ■□□□□■
  ■□□□□□□■
   ■□□□□■
    □□□■
     □□
"
$charge10 = "
     ■■
    ■□□■
   ■□□□□■
  ■□□□□□□■
   □□□□□■
    □□□■
     □■
"
$charge11 = "
     ■■
    ■□□■
   ■□□□□■
  □□□□□□□■
   □□□□□■
    □□□■
     ■■
"
$charge12 = "
     ■■
    ■□□■
   □□□□□■
  □□□□□□□■
   □□□□□■
    ■□□■
     ■■
"
$charge13 = "
     ■■
    □□□■
   □□□□□■
  □□□□□□□■
   ■□□□□■
    ■□□■
     ■■
"
$charge14 = "
     □■
    □□□■
   □□□□□■
  ■□□□□□□■
   ■□□□□■
    ■□□■
     ■■
"
$termine1 = "
            ▄▀
          ▄▀
 ▀▄     ▄▀
   ▀▄▄▄▀
"

#=======================================================#

# Fonctions #

function CorecteurMdp
{
        ##########################
        #  Pour appeler la fonc  #
        ##########################
        # CorecteurMdp -Mdp "$Password"
        ##########################
    param (
            $Mdp
        )
    # Changement du titre
    $host.ui.RawUI.WindowTitle = "Verification De la validitée du MDP"
    function Majuscule
    {
        #########################
        #  Pour appeler la fonc #
        #########################
        # $Return = Majuscule -Mdp "$Mdp"
        # Ajout de la valeur $Mdp
        param (
            $Mdp
        )
        # Variable de validation de Majuscule
        $Errorlevel = 1
        $Mdp = "$Mdp"
        #############################
        if ($Mdp -cmatch "[A-Z]") {Write-Host "[ OK ] " -ForegroundColor Green -NoNewline; Write-Host  "Majuscule"; Return $Errorlevel = 1} else {Return $Errorlevel = "Maju"}
    }
    function Minuscule
    {
        #########################
        #  Pour appeler la fonc #
        #########################
        # $Return = Minuscule -Mdp "$Mdp"
        # Ajout de la valeur $Mdp
        param (
            $Mdp
        )
        # Variable de Niveau d'erreur
        $Errorlevel = 1
        $Mdp = "$Mdp"
        #############################
        if ($Mdp -cmatch "[a-z]") {Write-Host "[ OK ] " -ForegroundColor Green -NoNewline; Write-Host  "Minuscule"; Return $Errorlevel = 1} else {Return $Errorlevel = "Minu"}
    }
    function Chiffre
    {
        #########################
        #  Pour appeler la fonc #
        #########################
        # $Return = Chiffre -Mdp "$Mdp"
        # Ajout de la valeur $Mdp
        param (
            $Mdp
        )
        # Variable de Niveau d'erreur
        $Errorlevel = 1
        $Mdp = "$Mdp"
        #############################
        if ($Mdp -match '(?=.*\d)') {Write-Host "[ OK ] " -ForegroundColor Green -NoNewline; Write-Host  "Chiffre"; Return $Errorlevel = 1} else {Return $Errorlevel = "chif"}
    }
    function Symboles
    {
        #########################
        #  Pour appeler la fonc #
        #########################
        # $Return = Symboles -Mdp "$Mdp"
        # Ajout de la valeur $Mdp
        param (
            $Mdp
        )
        # Variable de Niveau d'erreur
        $Errorlevel = 1
        $Mdp = "$Mdp"
        #############################
        if ($Mdp -match '(?=.*[^\w\d\s])') {Write-Host "[ OK ] " -ForegroundColor Green -NoNewline; Write-Host  "Symboles"; Return $Errorlevel = 1} else {Return $Errorlevel = "symb"}
    }
    function Count
    {
        #########################
        #  Pour appeler la fonc #
        #########################
        # $Return = Count -Mdp "$Mdp"
        # Ajout de la valeur $Mdp
        param (
            $Mdp
        )
        # Variable de Niveau d'erreur
        $Errorlevel = 1
        #############################
        if ([int]$Mdp.Length -gt 7) {Write-Host "[ OK ] " -ForegroundColor Green -NoNewline; Write-Host  "Taile respectée"; Return $Errorlevel = 1} else {Return $Errorlevel = "coun"}
    }
    ###########################################################
    [string]$UserMdp = "$Mdp"
    $Errorlevel = Count -Mdp "$UserMdp"
    if ( "$Errorlevel" -eq "coun" ) {"[ ERREUR ] " + "Le Mot de passe est trop court !" >> "$PWD\Rapport\$Raport"; $Random = "" ; for ([int]$i = 0; $i -lt 8; [int]$i++) { $Random = [char](Get-Random -Minimum 33 -Maximum 126); $Corection = "$Random" + "$Corection";} $UserMdp = "$Corection" + "$UserMdp"; } else { $Exit = $Exit + 1}
    $Errorlevel = Symboles -Mdp "$UserMdp"
    if ( "$Errorlevel" -eq "symb" ) {"[ ERREUR ] " + "Le Mot de passe doi contenire des Simbole special !" >> "$PWD\Rapport\$Raport"; $Corection = [char](Get-Random -Minimum 33 -Maximum 47); $UserMdp = "$Corection" + "$UserMdp"; } else { $Exit = $Exit + $Exit}
    $Errorlevel = Chiffre -Mdp "$UserMdp"
    if ( "$Errorlevel" -eq "chif" ) {"[ ERREUR ] " + "Le Mot de passe doi contenire des Chiffres !" >> "$PWD\Rapport\$Raport"; $Corection = Get-Random -Minimum 1 -Maximum 100; $UserMdp = "$Corection" + "$UserMdp"; } else { $Exit = $Exit + $Exit}
    $Errorlevel = Minuscule -Mdp "$UserMdp"
    if ( "$Errorlevel" -eq "minu" ) {"[ ERREUR ] " + "Le Mot de passe doi contenire des lettre Minuscule !" >> "$PWD\Rapport\$Raport"; $Corection = [char](Get-Random -Minimum 97 -Maximum 122); $UserMdp = "$Corection" + "$UserMdp"; } else { $Exit = $Exit + $Exit}
    $Errorlevel = Majuscule -Mdp "$UserMdp"
    if ( "$Errorlevel" -eq "maju" ) {"[ ERREUR ] " + "Le Mot de passe doi contenire des lettre Majuscule !" >> "$PWD\Rapport\$Raport"; $Corection = [char](Get-Random -Minimum 65 -Maximum 90); $UserMdp = "$Corection" + "$UserMdp"; } else { $Exit = $Exit + $Exit}
    if ($Exit -eq 16) {break}
    # Affichage Pour test
    # Write-host "Le mdp: '$UserMdp'"
    return $UserMdp
}
#===============================================================#
# Verification que AD et instalée
Write-Host "Verification en cours ..."
$x = Get-ADReplicationFailure localhost
$Errorlevel = $?
clear
if ( $Errorlevel -eq $False )
{
    # Changement de la tail de fenêtre
    mode con cols=60 lines=15
    Write-Host "[ ERREUR ] " -ForegroundColor Red -NoNewLine
    Write-Host "$StrNoAD"
    "[ ERREUR ] $StrNoAD" >> "$PWD\Rapport\$Raport"
    Start-Sleep 20
    exit
}
else {
    clear
}
##################################
# Reconcaténée les str en retirent les espace est saut de ligne
$x = $x.Partner
$xx = "$x"
$x = $xx.Split(',')
$xx = $x | Select-String "DC="
$x = $xx -replace(' ')
# DC contien le vrais DC trouvée localement
$DC = $x -join(",")
#################################
# Changement de la secion
$host.ui.RawUI.WindowTitle = “Recherche de fichier Users.csv”

# Verification ci fichier Temporaire existe
$Errorlevel = Test-Path -Path "$PWD\MesCSV.txt" -PathType Leaf
if ( $Errorlevel -eq $True)
{
    # Ci il existe il est suprimé
    Remove-Item -Path "$PWD\MesCSV.txt" 
    Write-Host "[ OK ] " -ForegroundColor Yellow -NoNewline
    Write-Host "$StrClearTemp"
}
# Commande de recherche de CSV
Start-Job -ScriptBlock {Get-ChildItem -Path "$env:USERPROFILE\" -Recurse -File -include "Users*.csv" | %{Add-Content -Path "$env:USERPROFILE\MesCSV1.txt" "$_"} -ErrorAction SilentlyContinue; Add-Content -Path "$env:USERPROFILE\MesCSV1.txt" "Terminer_XXXX"}
for ($i = 0; $i -lt 1;) {
# Verifier que tache finit
$Exist = Test-Path -Path "$env:USERPROFILE\MesCSV1.txt" -PathType Leaf
# Fin de boucle ci fichier terminé
if ( $Exist -eq $True )
{
     $Terminer = Get-Content -Path "$env:USERPROFILE\MesCSV1.txt" -Tail 1
     if ( $Terminer -eq "Terminer_XXXX" )
     {
          clear
          # Move-Item -Path "$env:USERPROFILE\MesCSV.txt" $location\
          $host.ui.RawUI.WindowTitle = “Recherche terminée !”
          Write-Host "▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬" -ForegroundColor Yellow
          Write-Host "$termine1" -ForegroundColor Green
          Write-Host "▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬" -ForegroundColor Yellow
          (Get-Content -Path "$env:USERPROFILE\MesCSV1.txt") -replace 'Terminer_XXXX','' >> $PWD\MesCSV.txt
          Remove-Item -Path "$env:USERPROFILE\MesCSV1.txt"
          Start-Sleep 2
          mode con cols=80 lines=30
          $host.ui.RawUI.WindowTitle = “Lecture du fichier CSV”
          clear
          break
     }
}
# Animation de chargement
Start-Sleep -Millisecond 200
clear
Write-Host $charge0 -ForegroundColor Yellow
Start-Sleep -Millisecond 200
clear
Write-Host $charge1 -ForegroundColor Yellow
Start-Sleep -Millisecond 200
clear
Write-Host $charge2 -ForegroundColor Yellow
Start-Sleep -Millisecond 200
clear
Write-Host $charge3 -ForegroundColor Yellow
Start-Sleep -Millisecond 200
clear
Write-Host $charge4 -ForegroundColor Yellow
Start-Sleep -Millisecond 200
clear
Write-Host $charge5 -ForegroundColor Yellow
Start-Sleep -Millisecond 200
clear
Write-Host $charge6 -ForegroundColor Yellow
Start-Sleep -Millisecond 200
clear
Write-Host $charge7 -ForegroundColor Yellow
Start-Sleep -Millisecond 200
clear
Write-Host $charge8 -ForegroundColor Yellow
Start-Sleep -Millisecond 200
clear
Write-Host $charge9 -ForegroundColor Yellow
Start-Sleep -Millisecond 200
clear
Write-Host $charge10 -ForegroundColor Yellow
Start-Sleep -Millisecond 200
clear
Write-Host $charge11 -ForegroundColor Yellow
Start-Sleep -Millisecond 200
clear
Write-Host $charge12 -ForegroundColor Yellow
Start-Sleep -Millisecond 200
clear
Write-Host $charge13 -ForegroundColor Yellow
Start-Sleep -Millisecond 200
clear
Write-Host $charge14 -ForegroundColor Yellow
}
# Rechuperation du nombre de ligne dans le fichiée
$NbLignes = Get-Content "$PWD\MesCSV.txt" | Measure-Object -Line
if ( $NbLignes.lines -gt 1 )
{
    $host.ui.RawUI.WindowTitle = “Célection du fichier a charger !”
    # Ci plusieurs fichiers troucée lesse l'utilisateur choisire le quel utiliser
    $EndTest = 0
    do {
        clear
        Write-Host "$BarreGros `n" -ForegroundColor DarkCyan
        Write-Host "$BarreDuAu `n" -ForegroundColor Magenta
        (Get-Content -Path "$PWD\MesCSV.txt") -replace 'C:',' →  C:'
        Write-Host "$BarreDuBa" -ForegroundColor Magenta
        Write-Host "`n"
        Write-Host "$StrChoiDuCSV `n"
        [string]$MonCSV = Read-Host "► " 
        # Verification du fichier selectioner et de son en tète
        if ( $MonCSV -is [string] )
        {
            $Errorlevel = Test-Path -Path "$MonCSV" -PathType Leaf
            if ( $Errorlevel -eq $True )
            {
                Write-Host "[ OK ] " -ForegroundColor Green -NoNewline
                Write-Host "$StrFichierExist"
                # chercher LastName,FirstName,UserName,Password,OrganizationalUnit,OrganizationalUnitName dans le fichier choisi
                [string]$x = Select-String -Path "$MonCSV" -Pattern "LastName,FirstName,UserName,Password,OrganizationalUnit"
                if ([string]::IsNullOrEmpty($x)) 
                {
                    Write-Host "[ ERREUR ] " -ForegroundColor Red -NoNewLine
                    Write-Host "$StrFichierExistPas"
                    "[ ERREUR ] $StrFichierExistPas" >> "$PWD\Rapport\$Raport"
                    Start-Sleep 5
                }
                else {
                    # Importation du CSV selectionée
                    $Users = Import-Csv "$MonCSV"
                    if ( $? -eq $True )
                    {
                        Write-Host "[ OK ] " -ForegroundColor Green -NoNewline
                        Write-Host "$StrFichierImporter"
                        Start-Sleep 3
                        $host.ui.RawUI.WindowTitle = “Lecture du CSV”
                        $EndTest = 1
                        Remove-Item -Path "$env:USERPROFILE\MesCSV.txt"
                        break
                    }
                    else {
                        Write-Host "[ ERREUR ] " -ForegroundColor Red -NoNewLine
                        Write-Host "$StrErreurImportFichier"
                        "[ ERREUR ] $StrErreurImportFichier" >> "$PWD\Rapport\$Raport"
                    }
                }
            }
            else {
                clear
                Write-Host "$StrErreurEntrerIncorect" -ForegroundColor Red
                "[ erreur ] Durent l'execution vous avez fait une erreur d'entrée" >> "$PWD\Rapport\$Raport"
                Start-Sleep 3
            }  
        }    
    } Until ( $EndTest -eq 1 )
}
# Ci il n'y a pas de ligne afiche une erreur
if ( $NbLignes.Lines -lt 1 )
{
    $Errorlevel = Test-Path -Path "$env:USERPROFILE\Desktop\Users_Exemple.csv" -PathType Leaf
    if ( $Errorlevel -eq $False )
    {
        
        "LastName,FirstName,UserName,Password,OrganizationalUnit" >> $env:USERPROFILE\Desktop\Users_Exemple.csv
        '"Nom_de_Famil","Prenom","Nom_D_Utilisateur","Mot_De_pass","OU=Unité_d_organisation,' + "$DC" + '"' >> $env:USERPROFILE\Desktop\Users_Exemple.csv
    }
    Remove-Item -Path "$PWD\MesCSV.txt"
    clear
    Write-Host "`n `n[ ERREUR ] " -ForegroundColor Red -NoNewline
    Write-Host "$StrFichierIntrouvabl`n" -ForegroundColor Yellow
    "[ ERREUR ] $StrFichierIntrouvabl" >> "$PWD\Rapport\$Raport"
    Write-Host "Un fichier vierge 'Users.csv' `ndevrais se trouver sur votre Bureau`nPour le complaiter suivée l'exemple.`n" -ForegroundColor Yellow
    Write-Host "Nom_de_Famil,Prenom,Nom_D_Utilisateur,Mot_De_pass,`nOU=Unité_d_organisation,$DC`n" -ForegroundColor Yellow
    Read-Host "Entrée une touche pour terminer !"
    exit
}
# Ci selement une ligne carge directement le fichier
if ( $NbLignes.Lines -eq 1 )
{
    $MonCSV = Get-Content -Path "$PWD\MesCSV.txt"
    $Users = Import-Csv "$MonCSV"
    Remove-Item -Path "$PWD\MesCSV.txt" 
}

#Fin Chargement du CSV
#===================================================================================================

$host.ui.RawUI.WindowTitle = “Décortiquage du fichier CSV”
foreach ($User in $Users) {
    $LastName = $User.LastName
    # Verification ci Fichier de base non changée stop tous
    if ($LastName -eq "Nom_de_Famil" )
    {
        clear
        Write-Host "[ ERREUR ] " -ForegroundColor Red -NoNewline
        Write-Host "Changez votre fichier Users_Exemple.csv `n           avec vos information 'Nom_de_Famil'"
        "[ erreur ] Vous avez oublier de changer le 'Nom_de_Famil' dans Users_Exemple.csv" >> "$PWD\Rapport\$Raport"
        Start-Sleep 10
        exit
    }
    $FirstName = $User.FirstName
    # Verification ci Fichier de base non changée stop tous
    if ($FirstName -eq "Prenom" )
    {
        clear
        Write-Host "[ ERREUR ] " -ForegroundColor Red -NoNewline
        Write-Host "Changez votre fichier Users_Exemple.csv `n           avec vos information 'Prenom'"
        "[ erreur ] Vous avez oublier de changer le 'Prenom' dans Users_Exemple.csv" >> "$PWD\Rapport\$Raport"
        Start-Sleep 10
        exit
    }
    $UserName = $User.UserName
    # Verification ci Fichier de base non changée stop tous
    if ($UserName -eq "Nom_D_Utilisateur" )
    {
        clear
        Write-Host "[ ERREUR ] " -ForegroundColor Red -NoNewline
        Write-Host "Changez votre fichier Users_Exemple.csv `n           avec vos information 'Nom_D_Utilisateur'"
        "[ erreur ] Vous avez oublier de changer le 'Nom_D_Utilisateur' dans Users_Exemple.csv" >> "$PWD\Rapport\$Raport"
        Start-Sleep 10
        exit
    }
    $Password = $User.Password
    # Verification ci Fichier de base non changée stop tous
    if ($Password -eq "Mot_De_pass" )
    {
        clear
        Write-Host "[ ERREUR ] " -ForegroundColor Red -NoNewline
        Write-Host "Changez votre fichier Users_Exemple.csv `n           avec vos information 'Mot_De_pass'"
        "[ erreur ] Vous avez oublier de changer le 'Mot_De_pass' dans Users_Exemple.csv" >> "$PWD\Rapport\$Raport"
        Start-Sleep 10
        exit
    }

    # Verification de la validitée du mot de passe cinon le corige
    $Password = CorecteurMdp -Mdp "$Password"

    # Découpage de OrganizationalUnit pour récupérer le OU=xxx suporte maximum 2 espace
    $OU = $User.OrganizationalUnit
    $xx = $User.OrganizationalUnit.Substring(0, $User.OrganizationalUnit.IndexOf(','))
	$xx = $xx -split('OU=')
    $xx = $xx -split" "
    $OUName = $xx[1] +  " " + $xx[2] + " " + $xx[3]
    $OUName = $OUName.Substring(0,$OUName.Length-1)
    # Verification ci Fichier de base non changée stop tous
    if ($OUName -eq "Unité_d_organisation" )
    {
        clear
        Write-Host "[ ERREUR ] " -ForegroundColor Red -NoNewline
        Write-Host "Changez votre fichier UsersUsers_Exemple.csv `n           avec vos information 'Unité_d_organisation'"
        "[ erreur ] Vous avez oublier de changer le 'Unité_d_organisation' dans Users_Exemple.csv" >> "$PWD\Rapport\$Raport"
        Start-Sleep 10
        exit
    }

    # Découpage de OrganizationalUnit pour les DC=Mon,DC=domaine,DC=local
    $xx = $User.OrganizationalUnit -split ",",2
    $DcPath = $xx[1]
    

$host.ui.RawUI.WindowTitle = “Ajout des Compt a l'Active Directory”

function AdUser {
    if (Get-ADUser -Filter {SamAccountName -eq $UserName}) {
        Write-Host -ForegroundColor Yellow -NoNewLine "[Warning] "
	    Write-Host "The user account $UserName already exists !`n"
    }
    else {
        New-ADUser `
        -Name "$FirstName $LastName" `
        -GivenName "$FirstName" `
        -Surname "$LastName" `
        -SamAccountName "$UserName" `
        -UserPrincipalName "$($UserName.ToLower())@mon.domaine.local" `
        -AccountPassword (ConvertTo-SecureString -AsPlainText "$Password" -Force) -Enable $true -ChangePasswordAtLogon $true `
        -Path "$OU"
        $CodeDerreur = $?
        if ( $CodeDerreur -eq $True ) 
        {
            Write-Host -ForegroundColor Green -NoNewLine "[OK] "
            Write-Host "The user account $UserName was added`n"
           $Errorlevel = Test-Path -Path "$env:USERPROFILE\Desktop\Compt_AD_Cree"
            if ( $Errorlevel -eq $False )
            {
                
                Mkdir "$env:USERPROFILE\Desktop\Compt_AD_Cree"
            }
            $FicherTxtNam = "$FirstName" + "_" + "$LastName"
            $Errorlevel = Test-Path -Path "$env:USERPROFILE\Desktop\Compt_AD_Cree\$FicherTxtNam.txt" -PathType Leaf
            if ( $Errorlevel -eq $False )
            {
                "##############################" >> "$env:USERPROFILE\Desktop\Compt_AD_Cree\$FicherTxtNam.txt"
                "# Information du compte crée #" >> "$env:USERPROFILE\Desktop\Compt_AD_Cree\$FicherTxtNam.txt"
                "##############################" >> "$env:USERPROFILE\Desktop\Compt_AD_Cree\$FicherTxtNam.txt"
                " " >> "$env:USERPROFILE\Desktop\Compt_AD_Cree\$FicherTxtNam.txt"
                "═══════════════════════════════════════════════" >> "$env:USERPROFILE\Desktop\Compt_AD_Cree\$FicherTxtNam.txt"
                " FirstName : $FirstName" >> "$env:USERPROFILE\Desktop\Compt_AD_Cree\$FicherTxtNam.txt"
                " LastName  : $LastName" >> "$env:USERPROFILE\Desktop\Compt_AD_Cree\$FicherTxtNam.txt"
                " UserName  : $UserName" >> "$env:USERPROFILE\Desktop\Compt_AD_Cree\$FicherTxtNam.txt"
                " Password  : $Password" >> "$env:USERPROFILE\Desktop\Compt_AD_Cree\$FicherTxtNam.txt"
                " DcPath    : $DcPath" >> "$env:USERPROFILE\Desktop\Compt_AD_Cree\$FicherTxtNam.txt"
                " E-mail    : $($UserName.ToLower())@mon.domaine.local" >> "$env:USERPROFILE\Desktop\Compt_AD_Cree\$FicherTxtNam.txt"
                "═══════════════════════════════════════════════" >> "$env:USERPROFILE\Desktop\Compt_AD_Cree\$FicherTxtNam.txt"
                " " >> "$env:USERPROFILE\Desktop\Compt_AD_Cree\$FicherTxtNam.txt"
                "################################################" >> "$env:USERPROFILE\Desktop\Compt_AD_Cree\$FicherTxtNam.txt"
                "# Crée grace au script de Denis & Kuroakashiro #" >> "$env:USERPROFILE\Desktop\Compt_AD_Cree\$FicherTxtNam.txt"
                "################################################" >> "$env:USERPROFILE\Desktop\Compt_AD_Cree\$FicherTxtNam.txt"
            }
        }
        else {
            Write-Host "[Unknown]" -ForegroundColor Yellow -NoNewLine
            Write-Host "New-ADUser a retournée une erreur !"
            "[ Unconnu ] New-ADUser a retournée une erreur ! '$CodeDerreur' " >> "$PWD\Rapport\$Raport"
        }
	
	
    }
}

    if (Get-ADOrganizationalUnit -Filter {DistinguishedName -eq $OU}) {
        AdUser
	}
	else {
        New-ADOrganizationalUnit -Name "$OUName" -Path "$DcPath"
        $CodeDerreur = $?
        if ( $CodeDerreur -eq $True )
        {
            Write-Host -ForegroundColor Green -NoNewLine "[OK] "
	        Write-Host "The Organizational Unit $OUName was created`n"
            AdUser
        }
	    else {
	        Write-Host "[Unknown]" -ForegroundColor Yellow -NoNewLine
            Write-Host "New-ADOrganizationalUnit a retournée une erreur !"
            "[ Unconnu ] New-ADOrganizationalUnit a retournée une erreur ! '$CodeDerreur' " >> "$PWD\Rapport\$Raport"
        }
    }


}

# Compt les ligne du rapport
$LineCount = (Get-Content -Path "$PWD\Rapport\$Raport").Count
if ( $LineCount -gt 7 )
{
    Write-Host "Le raport d'erreur contien des Information !"
    Start-Process -FilePath "$PWD\Rapport\$Raport"
}
else {
    Remove-Item -Path "$PWD\Rapport\$Raport"
}


Write-Host "`n`n$BarreGros " -ForegroundColor Magenta
Read-Host "Entrée une touche pour terminer !" 
exit
