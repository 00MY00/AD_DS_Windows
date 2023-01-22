################################################
#            Auteur Denis                      #
################################################
#                                              #
# Le script permet d'ajouter des utilisateur   #
# a un active directori.                       #
#                                              #
#Il a été crée dans le cadre d'un cours N°'XXX'#
#                                              #
# Des amelioration on été aporter par          #
# Kuroakashiro pour le style et la simplicitée #
# d'utilisation du script                      #
################################################

# Version 1.1

# Importation du Module Active Directory
Import-Module ActiveDirectory

# Affichage de txt en UTF8
chcp 65001
# Changement de la tail de fenêtre
mode con cols=35 lines=15
# Changement du titre pour conaitre l'étape actuelle du script
$host.ui.RawUI.WindowTitle = “Verification De AD”

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
#===================#

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
    Start-Sleep 20
    exit
}
else {
    clear
}
##################################

# NB de DC=
# $x = Get-ADReplicationFailure localhost
# $NbDC = ([regex]::Matches($xx, "DC=" )).count
$x = $x.Partner
$xx = "$x"
$x = $xx.Split(',')
$xx = $x | Select-String "DC="
$x = $xx -replace(' ')
# DC contien le vrais DC trouvée localement
$DC = $x -join(",")


# Reconcaténée les str en retirent les espace est saut de ligne



#################################
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

Start-Job -ScriptBlock {Get-ChildItem -Path "$env:USERPROFILE\" -Recurse -File -include "Users*.csv" | %{Add-Content -Path "$env:USERPROFILE\MesCSV1.txt" "$_"} -ErrorAction SilentlyContinue; Add-Content -Path "$env:USERPROFILE\MesCSV1.txt" "Terminer_XXXX"}
for ($i = 0; $i -lt 1;) {
# Verifier que tache finit
$Exist = Test-Path "$env:USERPROFILE\MesCSV1.txt"
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
                    }
                }

                
            }
            else {
                clear
                Write-Host "$StrErreurEntrerIncorect" -ForegroundColor Red
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
    Write-Host "Un fichier vierge 'Users.csv' `ndevrais se trouver sur votre Bureau`nPour le complaiter suivée l'exemple.`n" -ForegroundColor Yellow
    Write-Host "Nom_de_Famil,Prenom,Nom_D_Utilisateur,Mot_De_pass,`nOU=Unité_d_organisation,$DC`n" -ForegroundColor Yellow
    Read-Host "Entrée une touche pour terminer !"
    exit
}



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
        Write-Host "Changée votre fichier UsersUsers_Exemple.csv `n           avec vos information 'Nom_de_Famil'"
        Start-Sleep 10
        exit
    }
    $FirstName = $User.FirstName
    # Verification ci Fichier de base non changée stop tous
    if ($FirstName -eq "Prenom" )
    {
        clear
        Write-Host "[ ERREUR ] " -ForegroundColor Red -NoNewline
        Write-Host "Changée votre fichier UsersUsers_Exemple.csv `n           avec vos information 'Prenom'"
        Start-Sleep 10
        exit
    }
    $UserName = $User.UserName
    # Verification ci Fichier de base non changée stop tous
    if ($UserName -eq "Nom_D_Utilisateur" )
    {
        clear
        Write-Host "[ ERREUR ] " -ForegroundColor Red -NoNewline
        Write-Host "Changée votre fichier UsersUsers_Exemple.csv `n           avec vos information 'Nom_D_Utilisateur'"
        Start-Sleep 10
        exit
    }
    $Password = $User.Password
    # Verification ci Fichier de base non changée stop tous
    if ($Password -eq "Mot_De_pass" )
    {
        clear
        Write-Host "[ ERREUR ] " -ForegroundColor Red -NoNewline
        Write-Host "Changée votre fichier UsersUsers_Exemple.csv `n           avec vos information 'Mot_De_pass'"
        Start-Sleep 10
        exit
    }
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
        Write-Host "Changée votre fichier UsersUsers_Exemple.csv `n           avec vos information 'Unité_d_organisation'"
        Start-Sleep 10
        exit
    }

    # Découpage de OrganizationalUnit pour les DC=Mon,DC=domaine,DC=local
    $xx = $User.OrganizationalUnit -split ",",2
    $DcPath = $xx[1]
    


    ## Affichage Test pour Débugage ##
    # Write-Host "'$LastName'"
    # Write-Host "'$FirstName'"
    # Write-Host "'$UserName'"
    # Write-Host "'$Password'"
    # Write-Host "'$OU'"
    # Write-Host "'$OUName'"
    # Write-Host "'$DcPath'"
    # Write-Host "'$($UserName.ToLower())@mon.domaine.local'"
    # Start-Sleep 5

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
        if ( $? -eq $True ) 
        {
            Write-Host -ForegroundColor Green -NoNewLine "[OK] "
            Write-Host "The user account $UserName was added`n"
            Resolve-Path -Path "$env:USERPROFILE\Desktop\Compt_AD_Cree" -Relative
            if ( $? -eq $False )
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
                "###############################################" >> "$env:USERPROFILE\Desktop\Compt_AD_Cree\$FicherTxtNam.txt"
                "# Crée grace au script de Denis & Kuroakashiro" >> "$env:USERPROFILE\Desktop\Compt_AD_Cree\$FicherTxtNam.txt"
                "###############################################" >> "$env:USERPROFILE\Desktop\Compt_AD_Cree\$FicherTxtNam.txt"
            }
        }
        else {
            Write-Host "[Unknown]" -ForegroundColor Yellow -NoNewLine
            Write-Host "New-ADUser a retournée une erreur !"
        }
	
	
    }
}

    if (Get-ADOrganizationalUnit -Filter {DistinguishedName -eq $OU}) {
        AdUser
	}
	else {
        New-ADOrganizationalUnit -Name "$OUName" -Path "$DcPath"
        if ( $? -eq $True )
        {
            Write-Host -ForegroundColor Green -NoNewLine "[OK] "
	        Write-Host "The Organizational Unit $OUName was created`n"
            AdUser
        }
	    else {
	        Write-Host "[Unknown]" -ForegroundColor Yellow -NoNewLine
            Write-Host "New-ADOrganizationalUnit a retournée une erreur !"
        }
    }


}
Write-Host "`n`n$BarreGros " -ForegroundColor Magenta
Read-Host "Entrée une touche pour terminer !" 
exit
