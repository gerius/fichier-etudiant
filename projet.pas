program PROJET;
uses crt;
type T_date= record
        jour: 1..31;
        mois: 1..12 ;
        annee: integer;
        end;
     T_etudiant= record
         MatE,NomE : string;
         Dnais: T_date;
         Filiere: string;
         Ncc: real;
         Nexam: real;
         end;
    Fiche= File of T_etudiant;
  var Etude: Fiche;
      Etu:T_etudiant;
     rep: string[1];
    i,j,choix: integer;
  PROCEDURE Creation (var Etude1: Fiche);
    begin
    clrscr;
    rewrite(Etude1);
    close(Etude1);
    end;
 PROCEDURE Ajout (var Etude2: Fiche) ;
   begin
   clrscr;
   RESET(Etude2);
   SEEK(Etude2,filesize(Etude2));
   i:=filesize(Etude2);
   repeat
   with Etu Do
   begin
   writeln('Entrer le Matricule de l''etudiant',i);
   readln(MatE);
   writeln('Entrer le Nom de l''etudiant',i);
   readln(NomE);
   writeln('Entrer la Date de naissance de l''etudiant',i);
      with Dnais Do
      begin
      readln(jour);
      readln(mois);
      readln(annee);
      end;
        writeln('Entrer la filiere de l''etudiant',i);
     readln(Filiere);
   writeln('Entrer la note du cc de l''etudiant',i);
   readln(Ncc);
   writeln('Entrer la note d''examen de l''etudiant',i);
   readln(Nexam);
   end;
   writeln('Valider la saisie (1) pour oui et (0) pour non?');
   readln(rep);
   if rep='1' then
   begin
   write(Etude2,Etu);
   i:=i+1;
   end;
   writeln('Continuer la saisie (1) pour oui et (0) pour non?');
   readln(rep);
   clrscr;
   until rep='0' ;
   close(Etude2);
   end;
  PROCEDURE Liste(var Etude3: Fiche);
  var Texte: text;
  begin
  clrscr;
  writeln('Afficher a l''ecran (1) ou dans un fichier texte (0)');
  readln(rep);
   reset (Etude3);
  if rep='1' then
  begin
  while not EOF(Etude3) do
  begin
  read(Etude3,Etu);
      with Etu do
      begin
      writeln('Matricule:',MatE);
      writeln('Nom:',NomE);
         with Dnais do
         begin
         writeln('Date De Naissance:',jour,'/',mois,'/',annee);
         end;
      writeln('Filiere:',Filiere);
      writeln('Note CC:',Ncc:2:2);
      writeln('Note D''Examen:',Nexam:2:2);
     end;
     writeln();
     Readkey;
   end;
   end
   else
   begin
   Assign(Texte,'c:\FPC\Projet\Textes.txt');
   writeln('La liste est dans le fichier: Textes.txt');
   rewrite(Texte);
    while not EOF(Etude3) do
  begin
  read(Etude3,Etu);
      with Etu do
      begin
      writeln(Texte,'Matricule:',MatE);
      writeln(Texte,'Nom:',NomE);
         with Dnais do
         begin
         writeln(Texte,'Date De Naissance:',jour,'/',mois,'/',annee);
         end;
      writeln(Texte,'Filiere:',Filiere);
      writeln(Texte,'Note Du CC:',Ncc:2:2);
      writeln(Texte,'Note D''Examen:',Nexam:2:2);
     end;
     writeln(Texte,' ');
   end;
   close(Texte);
   end;
    close(Etude3);
  end;
  PROCEDURE AfficheInfo( var Etude4: Fiche);
  var f:integer;
  begin
  clrscr;
  reset(Etude4);
  f:=filesize(Etude4)-1 ;
  repeat
  writeln('entrer la position de l''etudiant: entre (0 - ',f,')');
  readln(j);
  until (j>=0) and (j<= f);
  SEEK(Etude4,j);
  read(Etude4,Etu);
      with Etu do
      begin
      writeln('Matricule:',MatE);
      writeln('Nom:',NomE);
         with Dnais do
         begin
         writeln('Date De Naissance:',jour,'/',mois,'/',annee);
         end;
      writeln('Filiere:',Filiere);
      writeln('Note CC:',Ncc:2:2);
      writeln('Note D''Examen',Nexam:2:2);
     end;
     close(Etude4);
  end;
  PROCEDURE Modification(var Etude5: Fiche);
  begin
  clrscr;
  reset(Etude5);
  repeat
   writeln('entrer la position de l''etudiant entre: (0 - ',filesize(Etude5)-1,')');
  readln(j);
  until (j>=0) and (j<= filesize(Etude5)-1);
  read(Etude5,Etu);
  SEEK(Etude5,j);
   with Etu Do
   begin
   writeln('Entrer le nouveau Matricule de l''etudiant');
   readln(MatE);
   writeln('Entrer le nouveau Nom de l''etudiant');
   readln(NomE);
   writeln('Entrer la nouvelle Date de naissance de l''etudiant');
      with Dnais Do
      begin
      readln(jour);
      readln(mois);
      readln(annee);
      end;
   writeln('Entrer la nouvelle filiere de l''etudiant');
   readln(Filiere);
   writeln('Entrer la nouvelle note du cc de l''etudiant');
   readln(Ncc);
   writeln('Entrer la nouvelle note d''examen de l''etudiant');
   readln(Nexam);
   end;
  write(Etude5,Etu);
  close(Etude5);
  end;
  FUNCTION NbAdmis(var Etude6:Fiche):integer;
  var moy:real;
      nb:integer;
  begin
  clrscr;
  reset(Etude6);
 nb:=0;
    while not EOF(Etude6) do
    begin
     read(Etude6,Etu);
    moy:=(Etu.Ncc*0.3)+(Etu.Nexam*0.7);
    if moy >= 10 then
    begin
    nb:=nb+1;
    end;
    end;
    NbAdmis:=nb;
    close(Etude6);
    end;
    PROCEDURE RechercheInfo(Var Etude7:Fiche);
    var MatR:string;
        Trouve:boolean;
    begin
    clrscr;
    reset(Etude7);
    writeln('entrer le Matricule Recherche:');
    readln(MatR);
    Trouve:=false;
    while not EOF(Etude7) and (Trouve=false) do
    begin
    read(Etude7,Etu);
    if MatR= Etu.MatE then
    begin
    Trouve:= true;
    end;
    end;
    if Trouve=true then
    begin
    Writeln('l''Etudiant existe:');
      with Etu do
      begin
      writeln('Matricule:',MatE);
      writeln('Nom:',NomE);
         with Dnais do
         begin
         writeln('Date De Naissance:',jour,'/',mois,'/',annee);
         end;
      writeln('Filiere:',Filiere);
      writeln('Note CC:',Ncc:2:2);
      writeln('Note D''Examen',Nexam:2:2);
     end;
     end
     else
     begin
     writeln('L''Etudiant N''existe pas');
     end;
    close(Etude7);
    end;
 PROCEDURE RechercheFiliere(Var Etude8:Fiche);
 var FilR:string;
     n:integer;
 begin
 clrscr;
 reset(Etude8);
 writeln('Entrer la Filiere:');
 readln(FilR);
 n:=0;
  while not EOF(Etude8) do
    begin
    read(Etude8,Etu);
    if FilR= Etu.Filiere then
    begin
      with Etu do
      begin
      writeln('Matricule:',MatE);
      writeln('Nom:',NomE);
         with Dnais do
         begin
         writeln('Date De Naissance:',jour,'/',mois,'/',annee);
         end;
      writeln('Filiere:',Filiere);
      writeln('Note CC:',Ncc:2:2);
      writeln('Note D''Examen:',Nexam:2:2);
      readkey;
     end;
     n:=n+1;
     writeln();
   end;
   end;
   if n=0 then
   begin
   writeln('Y''a aucun etudiant de cette filiere');
   end;
   close(Etude8);
   end;
  PROCEDURE Supprimer(var Etude9:Fiche);
  var Mat:string;
      EtudeT:Fiche;
  begin
     clrscr;
     Assign(EtudeT,'c:\FPC\Projet\FichierT.dat');
     rewrite(EtudeT);
     reset(Etude9);
      repeat
   writeln('entrer la position de l''etudiant entre: (0 - ',filesize(Etude9)-1,')');
  readln(j);
  until (j>=0) and (j<= filesize(Etude9)-1);
  seek(Etude9,j);
  Mat:=Etu.MatE;
  reset(Etude9);
  while not EOF(Etude9) do
  begin
  read(Etude9,Etu);
  if Mat <> Etu.MatE then
  begin
  write(EtudeT,Etu);
  end;
  end;
  rewrite(Etude9);
  reset(EtudeT);
  while not EOF(EtudeT) do
  begin
  read(EtudeT,Etu);
  Write(Etude9,Etu);
  end;
  close(EtudeT);
  close(Etude9);
  erase(EtudeT);
  end;
  PROCEDURE Trier(var Etude10:Fiche);
  var Etu1,Etu2:T_etudiant;
  begin
  clrscr;
  reset(Etude10);
    for i:=0 to filesize(Etude10)-2 do
    begin
    seek(Etude10,i);
    read(Etude10,Etu1);
     for j:=i+1 to filesize(Etude10)-1 do
     begin
     seek(Etude10,j);
     read(Etude10,Etu2);
     if Etu1.NomE > Etu2.NomE then
     begin
     seek(Etude10,i);
     write(Etude10,Etu2);
     seek(Etude10,j);
     write(Etude10,Etu1);
     Etu1:=Etu2;
     end;
     end;
  end;
  close(Etude10);
  end;
begin
clrscr;
Assign (Etude,'c:\FPC\Projet\Fichier_Etudiant.dat');
Textcolor(11);
repeat
for i:=2 to 35 do
begin
gotoxy(i,1);
write('_');
end;
writeln();
writeln();
write('       '); writeln('  MENU OPERATION');
     for i:=11 to 22 do
begin
gotoxy(i,4);
write('-');
end;
writeln();
writeln();
writeln('   1-Pour la Creation');
writeln('   2-Pour Ajoute');
writeln('   3-Pour la Liste');
writeln('   4-Pour les Informations');
writeln('   5-Pour la Modification');
writeln('   6-pour le Nombre d''Admis');
writeln('   7-Pour la Recherche des Infos');
writeln('   8-Pour la Recherche par Filiere');
writeln('   9-Pour Supprimer un etudiant');
writeln('  10-pour le trie des Noms');
for i:=2 to 35 do
begin
gotoxy(i,16);
write('_');
end;
for i:=2 to 16 do
begin
gotoxy(1,i);
write('|');
end;
for i:=2 to 16 do
begin
gotoxy(36,i);
write('|');
end;
writeln();
writeln();
writeln(' Entrer votre choix:');
readln(choix);
case choix of
1: Creation (Etude);
2: Ajout (Etude);
3: Liste(Etude);
4: AfficheInfo(Etude);
5: Modification(Etude);
6: writeln('Le nombres d''amids est:', NbAdmis(Etude));
7: RechercheInfo(Etude);
8: RechercheFiliere(Etude);
9: Supprimer(Etude);
10: Trier(Etude);
else
writeln('Erreur sur le choix');
end;
writeln('voulez vous sorti du programme (1) pour oui et (0) pour non?');
readln(rep);
clrscr;
until   rep='1' ;
end.
