%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                                                                                       %
%                                                   Quel est le meilleur pays pour s'expatrier?                             
%                                                                                                                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



clear all;
%initialisation des variables
irr1= [];
irr2=[];

NBPAYS=29;
SCOREPAYS=zeros(NBPAYS,2);
I=0;

%initialisation des systemes flous
%premiere branche
SF1=readfis('SF1-Resistance.fis');
SF2=readfis('SF2-InteretMedical.fis');
%seconde branche
SF3=readfis('SF3-AdequationCulturelle.fis');
SF4=readfis('SF4-AdequationModeVie.fis');
SF5=readfis('SF5-InteretPsychologique.fis');
%troisieme branche
SF6=readfis('SF6-AdequationNiveauVie.fis');
SF7=readfis('SF7-AdequationEtudes.fis');
SF9=readfis('SF9-InteretEconomique.fis'); 
SF8=readfis('SF8-InteretEconomiqueRetraite.fis');
%Résultat final
SF10=readfis('SF10-InteretPays.fis');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                Affichages des formulaires
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Santé
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%on recupere les données en entrée en utilisant la fonction inputdlg
prompt={'Combien de fois par an allez vous chez le médecin en général?',...
       'Portez-vous des lunettes? -Entrez 0 pour non 1 pour oui-',...
       'Etes vous diabetique? Avez-vous du cholestérol? -Entrez 0 pour non 1 pour oui-',...
       'Avez vous des allergies? -Entrez 0 pour non 1 pour oui-',...
       'Avez-vous un traitement médical permanent? -Entrez 0 pour non 1 pour oui-',...
       'Avez-vous un handicap moyen (difficultés à se déplacer)? -Entrez 0 pour non 1 pour oui-',...
       'Avez-vous un gros handicap (fauteuil roulant)? -Entrez 0 pour non 1 pour oui-',...
       'Quel age avez-vous?'};
defaut={'4','1','0','1','0','0','0','30'};
titre= 'Evaluation de votre santé';
n_lignes=1;
options.Resize='on';
answer1= inputdlg(prompt,titre,n_lignes,defaut,options);
       
%si on a cliqué sur cancel answer1 est vide, il faut sortir du programme
if isempty(answer1),
    disp('Action annulée');
    return;
end;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         Culture
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%on recupere les données en entrée en utilisant la fonction inputdlg
prompt={'Le week-end, vous vous: 0-reposez 1-sortez',...
        'Combien de fois par ans allez vous dans un musée?',...
        'Quels genres de films allez vous voir de préférence? 0-les films d''auteurs 1-comédies, films d''animation 2-les films populaires et blockbusters 3-je n''aime pas le cinéma',...
        'Quand vous avez le choix, vous regardez vos films: 0-en VO 1-en VF?',...
        'Quand vous allez au restaurant c''est pour: 0-un plat du terroir 1-une découverte gustative 2-je vais peu au restaurant',...
        'Si une tradition du pays où vous êtes est de manger avec les mains dans des plats partagés avec les différents convives, le feriez vous? 0-oui 1-non'
        };
defaut={'0','3','0','1','0','0'}; % Valeurs par défaut
titre= 'Evaluation de l''interet culturel';
answer2= inputdlg(prompt,titre,n_lignes,defaut,options);

%si on a cliqué sur cancel answer1 est vide, il faut sortir du programme
if isempty(answer2),
    disp('Action annulée');
    return;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         Aventure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%


prompt={'En vacances, vous allez: 0-voir votre famille 1-chaque année au meme endroit pour me ressourcer 2-changer d''air dans un lieu touristique 3-barouder',...
        'Avec de l''argent, prefereriez-vous: 0-vous acheter une villa 1-faire le tour du monde 2-ne rien changer à votre vie',...
        'Aimeriez vous apprendre de nouvelles langues? 0-oui 1-non',...
        'Etes vous satisfait de votre travail? 0-beaucoup 1-pas mal 2-non',...
        'Etes vous satisfait de votre environnement? 0-beaucoup 1-pas mal 2-non',...
        'Etes vous satisfait de votre situation familiale? 0-beaucoup 1-pas mal 2-non',...
        'Vous faites vous rapidement de nouvelles connaissances? 0-oui 1-non',...
        'Pendant une année sabatique, iriez vous: 0-faire de l''humanitaire 1-m''enrichir personnellement et entretenir mon bien être',...
        'Accepteriez-vous de prendre des douches froides tout le reste de votre vie? 0-oui 1-non',...
        'Vous prefereriez une vie: 0-routinière 1-instable?',...
        'Voulez vous partir: 0-seul 1-famille?',...
        'Passer Noël sans votre famille: 0-inconcevable 1-on trouve toujours un amis pour nous inviter 2-Cool! ça changera!',...
          };
defaut={'0','0','0','0','0','0','0','0','0','0','0','0','0'}; % Valeurs par défaut
titre= 'Evaluation de votre envie d''aventure';

answer3= inputdlg(prompt,titre,n_lignes,defaut,options);

%si on a cliqué sur cancel answer1 est vide, il faut sortir du programme
if isempty(answer3),
    disp('Action annulée');
    return;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         Langues
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
prompt={'Notez votre niveau de 0 à 100 en: Anglais',...
        'Allemand',...
        'Espagnol',...
        'Arabe',...
        'Chinois',...
        'Indien Bangali',...
        'Russe'
        
     };
defaut={'0','0','0','0','0','0','0'}; % Valeurs par défaut
titre= 'Evaluation des langues parlées';
n_lignes=1;
answer4= inputdlg(prompt,titre,n_lignes,defaut,options);

%si on a cliqué sur cancel answer1 est vide, il faut sortir du programme
if isempty(answer4),
    disp('Action annulée');
    return;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%      Actif/Retraité
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
prompt={'Etes-vous: 0-retraité 1-actif  2-vous ne voulez pas travailler?'};
defaut={'1'}; % Valeur par défaut
titre= 'Votre activité';
n_lignes=1;
answer5= inputdlg(prompt,titre,n_lignes,defaut,options);

%si on a cliqué sur cancel answer1 est vide, il faut sortir du programme
if isempty(answer5),
    disp('Action annulée');
    return;
end;
actif=str2double(answer5{1});


%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Niveau de vie
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prompt={'En sachant que 0 serait "vivre d''amour et d''eau fraiche", 100 serait "vivre fastueusement", quelle est votre espérance minimale de niveau de vie:',...
        'Idéalement, votre niveau de vie serait compris entre:',...
        'Et:',...
        'Au maximum vous esperez:'
};
defaut={'45','50','50','55'}; % Valeurs par défaut
titre= 'Evaluation de votre demande de niveau de vie';
n_lignes=1;
answer6= inputdlg(prompt,titre,n_lignes,defaut,options);

%si on a cliqué sur cancel answer1 est vide, il faut sortir du programme
if isempty(answer6),
    disp('Action annulée');
    return;
end;

niveau_vie_1=str2double(answer6{1});
niveau_vie_2=str2double(answer6{2});
niveau_vie_3=str2double(answer6{3});
niveau_vie_4=str2double(answer6{4});

%on fait le traitement des données dans la même boucle
if actif==1, % Affichage des fomulaires seulement si actif
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %     Niveau d'étude
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%
        prompt={'Combien d''années d''études après le bac avez vous effectué? 0-Si vous n''avez pas le bac'};
        defaut={'0'}; % Valeurs par défaut
        titre= 'Evaluation de votre niveau d''études';
        n_lignes=1;
        answer7= inputdlg(prompt,titre,n_lignes,defaut,options);

        %si on a cliqué sur cancel answer1 est vide, il faut sortir du programme
        if isempty(answer7),
            disp('Action annulée');
            return;
        end;

        %traitement
        etudes=str2double(answer7{1});
        if etudes>8,
            etudes=8;
        end;
        if etudes<0,
            etudes=0;
        end;


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %     Quantité de travail
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%
        prompt={'Combien d''heures par semaine minimum souhaitez-vous travailler?',...
                'Dans l''idéal vous travailleriez entre:',...
                'Et',...
                'Au maximum, vous souhaitez travailler:',...
                'Et combien de semaine de vacances minimum par an souhaitez-vous?',...
                'Dans l''idéal entre:',...
                'Et',...
                'Au maximum:'};
        defaut={'30','30','35','35','5','5','5','5'}; % Valeurs par défaut
        titre= 'Evaluation de quantité de travail souhaité';
        n_lignes=1;
        answer8= inputdlg(prompt,titre,n_lignes,defaut,options);

        %si on a cliqué sur cancel answer1 est vide, il faut sortir du programme
        if isempty(answer8),
            disp('Action annulée');
            return;
        end;


        %traitement
        heures_1=str2double(answer8{1});
        semaines_1=str2double(answer8{5});
        qt_travail_1=heures_1*(52-semaines_1);
        heures_2=str2double(answer8{2});
        semaines_2=str2double(answer8{6});
        qt_travail_2=heures_2*(52-semaines_2);
        heures_3=str2double(answer8{3});
        semaines_3=str2double(answer8{7});
        qt_travail_3=heures_3*(52-semaines_3);
        heures_4=str2double(answer8{4});
        semaines_4=str2double(answer8{8});
        qt_travail_4=heures_4*(52-semaines_4);
       
    
    elseif actif==2,

        %%%%%%%%%%%%%%%%%%%
        %     Au repos
        %%%%%%%%%%%%%%%%%%%

        % Affichage sabatique    
        prompt={'Grâce à vos économies et à un peu de débrouille sur place, avec combien d''argent (en euros) comptez vous vivre par mois au minimum',...
                'Dans l''idéal vous auriez entre:',...
                'Et:',...
                'Au maximum vous souhaiteriez:'
        };
        defaut={'700','900','1000','2000'};
        titre= 'Evaluation de votre autonomie';
        n_lignes=1;
        answer10= inputdlg(prompt,titre,n_lignes,defaut,options);
        
            %traitement
        rente_1=str2double(answer10{1});
        rente_1=rente_1*12*1.2996;
        rente_2=str2double(answer10{2});
        rente_2=rente_2*12*1.2996;
        rente_3=str2double(answer10{3});
        rente_3=rente_3*12*1.2996;
        rente_4=str2double(answer10{4});
        rente_4=rente_4*12*1.2996;
        
   
    else      
        
    
        %Debut affichage relatif retraité

        %%%%%%%%%%%%%%%%%%%
        %     Retraite
        %%%%%%%%%%%%%%%%%%%
        prompt={'Quel est le montant mensuel de votre retraite en euros?'};
        defaut={'1000'};
        titre= 'Evaluation de votre retraite';
        n_lignes=1;
        answer9= inputdlg(prompt,titre,n_lignes,defaut,options);

        %si on a cliqué sur cancel answer1 est vide, il faut sortir du programme
        if isempty(answer9),
            disp('Action annulée');
            return;
        end;

        %traitement
        rente=str2double(answer9{1});
        rente=rente*12*1.2996;
       

    
end; %Fin des affichages conditionnés par activité


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                      Traitement des données utilisateur
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Données santé
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%traduction des caractères en valeur numérique
medecin=str2double(answer1{1});
lunette=str2double(answer1{2});
diab=str2double(answer1{3});
allergies=str2double(answer1{4});
traitement=str2double(answer1{5});
m_handicap=str2double(answer1{6});
g_handicap=str2double(answer1{7});
age=str2double(answer1{8});

sante=0;
if lunette==1,
    sante=sante+5;
end;
if diab==1,
    sante=sante+30;
end;
if allergies==1,
    sante=sante+15;
end;
if traitement==1,
    sante=sante+30;
end;
if m_handicap==1,
    sante=sante+35;
end;
if g_handicap==1,
    sante=sante+60;
end;

sante=sante+medecin*5;

if sante>=100,
    sante=100;
end;

str = sprintf('Vous avez un score fragilite de %d', sante);
disp(str);

%SF1: evaluation de l'état de santé de l'utilisateur

[sortie1, irr1, orr, arr]=evalfis([sante,age],SF1);
%le ET est modélisé par un min qui n'est ni optimiste ni pessimiste
%calcul du degré de déclenchement de chaque règle
declenchementSF1=min(irr1, [], 2); 

nbruleSF1=length(SF1.rule); %Nb de regles du SF1
nbCsqSF1=length(SF1.output.mf);%Nb de classes de sortie
csqSF1=zeros(1,nbCsqSF1);

% Conséquence finale par max-union des conséquences floues partielles
for i = 1:nbruleSF1,
    csqSF1(SF1.rule(i).consequent)=max(csqSF1(SF1.rule(i).consequent), declenchementSF1(i));
end

%Sortie du système
if csqSF1(1)==1 && csqSF1(2)==0 && csqSF1(3)==0,
    disp('Imposteur. Vous etes trop handicapé pour vous servir de cet ordinateur! Vous feriez mieux de rester chez vous. A bientot à vos obsèques');
    return
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Données culture
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%traduction des caractères en valeur numérique
sortant=str2double(answer2{1});
musee=str2double(answer2{2});
films=str2double(answer2{3});
versionfilms=str2double(answer2{4});
resto=str2double(answer2{5});

culture_utilisateur=0;
if sortant==1,
    culture_utilisateur=40;
end;
if films==0,%auteur
    culture_utilisateur=culture_utilisateur+20;
end;
if films==1,%anim
    culture_utilisateur=culture_utilisateur+15;
end;
if films==2,%blockbuster
    culture_utilisateur=culture_utilisateur+5;
end;
if versionfilms==0,
    culture_utilisateur=culture_utilisateur+10;
end;
if resto==0
    culture_utilisateur=culture_utilisateur+5;
end;
if resto==1
    culture_utilisateur=culture_utilisateur+15;
end;
musee=musee*5;
if musee>35,
    musee=35;
end;

culture_utilisateur=culture_utilisateur+musee;

if culture_utilisateur>=100,
    culture_utilisateur=100;
end;


str = sprintf('Vous avez un score culture de %d', culture_utilisateur);
disp(str);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Données aventure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%traduction des caractères en valeur numérique
vacances=str2double(answer3{1});
argent=str2double(answer3{2});
nouvelle_langue=str2double(answer3{3});
travail=str2double(answer3{4});
environnement=str2double(answer3{5});
situation=str2double(answer3{6});
connaissances=str2double(answer3{7});
humanitaire=str2double(answer3{8});
douche=str2double(answer3{9});
routine=str2double(answer3{10});
famille=str2double(answer3{11});
noel=str2double(answer3{12});


aventure=0;
if famille==1,
    aventure=aventure-20;
end;
if vacances==1,
    aventure=aventure+5;
end;
if vacances==2,
    aventure=aventure+15;
end;
if vacances==3,
    aventure=aventure+30;
end;
if argent==0,
    aventure=aventure+5;
end;
if argent==1,
    aventure=aventure+15;
end;
if nouvelle_langue==0,
    aventure=aventure+20;
end;
if travail==1,
    aventure=aventure+10;
end;
if travail==2,
    aventure=aventure+15;
end;
if environnement==1,
    aventure=aventure+10;
end;
if environnement==2,
    aventure=aventure+20;
end;
if situation==1,
    aventure=aventure+10;
end;
if situation==2,
    aventure=aventure+20;
end;
if connaissances==0,
    aventure=aventure+10;
end;
if humanitaire==0,
    aventure=aventure+10;
end;
if douche==0,
    aventure=aventure+10;
end;
if douche==1 && aventure>50,
    aventure=aventure-20;
end;
if routine==1,
    aventure=aventure+10;
end;
if routine==0 && aventure>50,
    aventure=aventure-10;
end;
if noel==2,
    aventure=aventure+10;
end;
if noel==0 && aventure>50,
    aventure=aventure-10;
end;

if aventure>=100,
    aventure=100;
end;
if aventure<=0,
    aventure=0;
end;

       
str = sprintf('Vous avez un score aventure de %d', aventure);
disp(str);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Données langues
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
langues=zeros(1,8);
%traduction des caractères en valeur numérique
langues(1)=1;% Français
langues(2)=(str2double(answer4{1})/100);% Anglais
langues(3)=(str2double(answer4{2})/100);% Allemand
langues(4)=(str2double(answer4{3})/100);% Espagnol
langues(5)=(str2double(answer4{4})/100);% Arabe
langues(6)=(str2double(answer4{5})/100);% Chinois
langues(7)=(str2double(answer4{6})/100);% Indien
langues(8)=(str2double(answer4{7})/100);% Russe



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            Traitement des données des différent pays
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

IMed=zeros(NBPAYS,1);
IPsy=zeros(NBPAYS,4);
IEco=zeros(NBPAYS,3);
for I= 1:NBPAYS, %%on boucle sur tous les pays
    
    %CAF: evaluation de la situation sanitaire des pays
    
    %[NUM,TXT,R]=xlsread('E:\Dropbox\SY10\Pays.xlsx'); %chez P
    
    [NUM,TXT,R]=xlsread('C:\Users\Sucat\Dropbox\SY10\Pays.xlsx'); %chez L
    
    notesanitaire=NUM(I,1)*(1-NUM(I,2))*NUM(I,3);
    
    %SF2: evaluation de la resistance physique de l'utilisateur au pays I
    [sortie2, irr2, orr, arr]=evalfis([notesanitaire,sortie1],SF2);
    nbruleSF2= length(SF2.rule);
    nbCsqSF2=length(SF2.output.mf);
    
    for i=1:nbruleSF2,
        irr2(i,2)=csqSF1(SF2.rule(i).antecedent(2));
    end;
    
    declenchementSF2= min(irr2, [], 2);
    
    csqSF2=zeros(1, nbCsqSF2);
    for i =1:nbruleSF2,
        csqSF2(SF2.rule(i).consequent)=max(csqSF2(SF2.rule(i).consequent),declenchementSF2(i));
    end;
    IMed(I,1)=csqSF2(1);
    IMed(I,2)=csqSF2(2);
    IMed(I,3)=csqSF2(3);
        
    
    
    %CAF: evaluation de la situation culturelle des pays
    culture_pays=NUM(I,6);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %SF3 evalution de l'adequation du pays avec la demande culturelle de
    %l'utilisateur
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [sortie3, irr3, orr, arr]=evalfis([culture_pays,culture_utilisateur],SF3);
    declenchementSF3=min(irr3, [], 2); 

    nbruleSF3=length(SF3.rule); %Nb de regles du SF3
    nbCsqSF3=length(SF3.output.mf);%Nb de classes de sortie
    csqSF3=zeros(1,nbCsqSF3);

    % Conséquence finale par max-union des conséquences floues partielles
    for i = 1:nbruleSF3,
        csqSF3(SF3.rule(i).consequent)=max(csqSF3(SF3.rule(i).consequent), declenchementSF3(i));
    end;
    
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %SF4 evaluation de l'adéquation mode de vie
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    niveau_langue=0;
    for i=1:1:8,
       temp=min(langues(i),NUM(I,21+i));
        if temp>niveau_langue,
            niveau_langue=temp;%on prend le max des min
        end;
    end;

    proxi_culturelle=NUM(I,12);
    [sortie4, irr4, orr, arr]=evalfis([aventure,niveau_langue,proxi_culturelle],SF4);
    
    declenchementSF4=min(irr4, [], 2); 

    nbruleSF4=length(SF4.rule); %Nb de regles du SF4
    nbCsqSF4=length(SF4.output.mf);%Nb de classes de sortie
    csqSF4=zeros(1,nbCsqSF4);

    % Conséquence finale par max-union des conséquences floues partielles
    for i = 1:nbruleSF4,
        csqSF4(SF4.rule(i).consequent)=max(csqSF4(SF4.rule(i).consequent), declenchementSF4(i));
    end;
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %SF5 evaluation interet psychologique au pays
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [sortie5, irr5, orr, arr]=evalfis([sortie3,sortie4],SF5);
    nbruleSF5= length(SF5.rule);
    nbCsqSF5=length(SF5.output.mf);
    irr5=zeros(nbruleSF5,2);
    for i=1:nbruleSF5,
        irr5(i,1)=csqSF3(SF5.rule(i).antecedent(1));
        irr5(i,2)=csqSF4(SF5.rule(i).antecedent(2));
    end;
    
    declenchementSF5= min(irr5, [], 2);
    
    csqSF5=zeros(1, nbCsqSF5);
    for i =1:nbruleSF5,
        csqSF5(SF5.rule(i).consequent)=max(csqSF5(SF5.rule(i).consequent),declenchementSF5(i));
    end;
    
    
    IPsy(I,1)=csqSF5(1);
    IPsy(I,2)=csqSF5(2);
    IPsy(I,3)=csqSF5(3);
    IPsy(I,4)=csqSF5(4);
     
    if actif==1, %l'utilisateur est actif
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %SF6 evaluation adequation niveau de vie
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [sortie6, irr6, orr, arr]=evalfis([niveau_vie_1,NUM(I,16)],SF6);
        
        deg6=degre(niveau_vie_1,niveau_vie_2,niveau_vie_3,niveau_vie_4, SF6.input(1));
        
        nbruleSF6= length(SF6.rule);
        for i=1:nbruleSF6,
             irr6(i,1)=deg6(SF6.rule(i).antecedent(1));
        end;
        declenchementSF6=min(irr6, [], 2); 
        nbruleSF6=length(SF6.rule); %Nb de regles du SF6
        nbCsqSF6=length(SF6.output.mf);%Nb de classes de sortie
        csqSF6=zeros(1,nbCsqSF6);
        % Conséquence finale par max-union des conséquences floues partielles
        for i = 1:nbruleSF6,
            csqSF6(SF6.rule(i).consequent)=max(csqSF6(SF6.rule(i).consequent), declenchementSF6(i));
        end;

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %SF7 evaluation adequation etudes
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [sortie7, irr7, orr, arr]=evalfis([etudes,NUM(I,14)],SF7);
        
        declenchementSF7=min(irr7, [], 2); 
        nbruleSF7=length(SF7.rule); %Nb de regles du SF7
        nbCsqSF7=length(SF7.output.mf);%Nb de classes de sortie
        csqSF7=zeros(1,nbCsqSF7);
        % Conséquence finale par max-union des conséquences floues partielles
        for i = 1:nbruleSF7,
            csqSF7(SF7.rule(i).consequent)=max(csqSF7(SF7.rule(i).consequent), declenchementSF7(i));
        end;

        %on fait une différence entre le nombre d'heure de travail
        %souhaitées et le nombre d'heures effectives dans le pays
        diff_1=qt_travail_1/NUM(I,15);
        if diff_1>5
            diff_1=5;
        end;
        diff_2=qt_travail_2/NUM(I,15);
        if diff_2>5
            diff_2=5;
        end;
        diff_3=qt_travail_3/NUM(I,15);
        if diff_3>5
            diff_3=5;
        end;
        diff_4=qt_travail_4/NUM(I,15);
        if diff_4>5
            diff_4=5;
        end;
        
    
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %SF9 evaluation interet economique
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [sortie9, irr9, orr, arr]=evalfis([sortie7,sortie6,diff_1],SF9);
        nbruleSF9=length(SF9.rule); %Nb de regles du SF9
        nbCsqSF9=length(SF9.output.mf);%Nb de classes de sortie
        
        
        
        deg9=degre(diff_1,diff_2,diff_3,diff_4, SF9.input(3));
            
        for i=1:nbruleSF9,
             irr9(i,1)=csqSF7(SF9.rule(i).antecedent(1));
             irr9(i,2)=csqSF6(SF9.rule(i).antecedent(2));
             irr9(i,3)=deg9(SF9.rule(i).antecedent(3));
        end;
        
        declenchementSF9=min(irr9, [], 2); 

        csqSF9=zeros(1,nbCsqSF9);
        % Conséquence finale par max-union des conséquences floues partielles
        for i = 1:nbruleSF9,
            csqSF9(SF9.rule(i).consequent)=max(csqSF9(SF9.rule(i).consequent), declenchementSF9(i));
        end;
        
        IEco(I,1)=csqSF9(1);
        IEco(I,2)=csqSF9(2);
        IEco(I,3)=csqSF9(3);
    
    else %l'utilisateur est retraité       
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %SF8 evaluation interet economique pour un retraité-sabatique
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        if actif==0,
            rapport_rente=rente/NUM(I,13);
            if rapport_rente>8,
                rapport_rente=8;
            end;
            [sortie8, irr8, orr, arr]=evalfis([rapport_rente,niveau_vie_1],SF8);
        end;
        
        nbruleSF8=length(SF8.rule); %Nb de regles du SF8
        
        if actif==2,
            rapport_rente_1=rente_1/NUM(I,13);
            if rapport_rente_1>8,
                rapport_rente_1=8;
            end;
            
            rapport_rente_2=rente_2/NUM(I,13);
            if rapport_rente_2>8,
                rapport_rente_2=8;
            end;
            
            rapport_rente_3=rente_3/NUM(I,13);
            if rapport_rente_3>8,
                rapport_rente_3=8;
            end;
            
            rapport_rente_4=rente_4/NUM(I,13);
            if rapport_rente_4>8,
                rapport_rente_4=8;
            end;
            
            
            deg8=degre(rapport_rente_1,rapport_rente_2,rapport_rente_3,rapport_rente_4, SF8.input(1));
            for i = 1:nbruleSF8,
            	irr8(i,1)=deg8(SF8.rule(i).antecedent(1));
            end;
        end;
        
        deg8bis=degre(niveau_vie_1,niveau_vie_2,niveau_vie_3,niveau_vie_4, SF8.input(2));
            
        for i=1:nbruleSF8,
             irr8(i,2)=deg8bis(SF8.rule(i).antecedent(2));
        end;
        
        nbCsqSF8=length(SF8.output.mf);%Nb de classes de sortie  
        declenchementSF8=min(irr8, [], 2); 
        csqSF8=zeros(1,nbCsqSF8);
        % Conséquence finale par max-union des conséquences floues partielles
        for i = 1:nbruleSF8,
            csqSF8(SF8.rule(i).consequent)=max(csqSF8(SF8.rule(i).consequent), declenchementSF8(i));
        end;
    
    IEco(I,1)=csqSF8(1);
    IEco(I,2)=csqSF8(2);
    IEco(I,3)=csqSF8(3);
    end;
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %SF10 evaluation interet final du pays
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    nbruleSF10=length(SF10.rule); %Nb de regles du SF9
    nbCsqSF10=length(SF10.output.mf);%Nb de classes de sortie
    irr10=zeros(nbruleSF10,3);
    
    for i=1:nbruleSF10,
         irr10(i,1)=csqSF2(SF10.rule(i).antecedent(1));
         irr10(i,2)=csqSF5(SF10.rule(i).antecedent(2));
         
         if actif==1, 
             irr10(i,3)=csqSF9(SF10.rule(i).antecedent(3));
         else %l'utilisateur est retraité ou ne veut pas travailler
             irr10(i,3)=csqSF8(SF10.rule(i).antecedent(3));
         end;
    end;
        
    declenchementSF10= min(irr10, [], 2);
    
    csqSF10=zeros(1, nbCsqSF10);
    for i =1:nbruleSF10,
        csqSF10(SF10.rule(i).consequent)=max(csqSF10(SF10.rule(i).consequent),declenchementSF10(i));
    end;
    
    
    
    %Algo Zalila
    SCOREPAYS(I,1)= I;
    if sum(csqSF10),
         SCOREPAYS(I,2)= (csqSF10(1)*0 +csqSF10(2)*(0.35) +csqSF10(3)*(0.65) +csqSF10(4)*0.9+csqSF10(5)*1)/(sum(csqSF10));
    else SCOREPAYS(I,2)=0;
    end;
    
end;


%Resultat final

%on tri le tableau
permut=true;
while permut
    permut=false;
    for I=1:1:NBPAYS-1,
        if SCOREPAYS(I,2)<SCOREPAYS(I+1,2),
            tmpindice=SCOREPAYS(I+1,1);
            tmpscore=SCOREPAYS(I+1,2);
            SCOREPAYS(I+1,2)=SCOREPAYS(I,2);
            SCOREPAYS(I+1,1)=SCOREPAYS(I,1);
            SCOREPAYS(I,2)=tmpscore;
            SCOREPAYS(I,1)=tmpindice;
            permut = true;
        end;
    end;
end;

resultat=struct('rang',{1; 2; 3; 4; 5; 6}, ... 
            'nom', {TXT(SCOREPAYS(1,1)+1,1); TXT(SCOREPAYS(2,1)+1,1); TXT(SCOREPAYS(3,1)+1,1); TXT(SCOREPAYS(4,1)+1,1); TXT(SCOREPAYS(5,1)+1,1); TXT(SCOREPAYS(6,1)+1,1) }, ...
            'score_total', {SCOREPAYS(1,2); SCOREPAYS(2,2); SCOREPAYS(3,2);SCOREPAYS(4,2);SCOREPAYS(5,2);SCOREPAYS(6,2)},...
            'interet_medical_Risque', {IMed(SCOREPAYS(1,1),1); IMed(SCOREPAYS(2,1),1);IMed(SCOREPAYS(3,1),1);IMed(SCOREPAYS(4,1),1);IMed(SCOREPAYS(5,1),1);IMed(SCOREPAYS(6,1),1)},...
            'interet_medical_Convenable', {IMed(SCOREPAYS(1,1),2); IMed(SCOREPAYS(2,1),2);IMed(SCOREPAYS(3,1),2);IMed(SCOREPAYS(4,1),2);IMed(SCOREPAYS(5,1),2);IMed(SCOREPAYS(6,1),2)},...
            'interet_medical_Ideal', {IMed(SCOREPAYS(1,1),3); IMed(SCOREPAYS(2,1),3);IMed(SCOREPAYS(3,1),3);IMed(SCOREPAYS(4,1),3);IMed(SCOREPAYS(5,1),3);IMed(SCOREPAYS(6,1),3)},...
            'interet_psycho_Risque', {IPsy(SCOREPAYS(1,1),1);IPsy(SCOREPAYS(2,1),1);IPsy(SCOREPAYS(3,1),1);IPsy(SCOREPAYS(4,1),1);IPsy(SCOREPAYS(5,1),1);IPsy(SCOREPAYS(6,1),1)},...
            'interet_psycho_Convenable', {IPsy(SCOREPAYS(1,1),2);IPsy(SCOREPAYS(2,1),2);IPsy(SCOREPAYS(3,1),2);IPsy(SCOREPAYS(4,1),2);IPsy(SCOREPAYS(5,1),2);IPsy(SCOREPAYS(6,1),2)},...
            'interet_psycho_Agreable', {IPsy(SCOREPAYS(1,1),3);IPsy(SCOREPAYS(2,1),3);IPsy(SCOREPAYS(3,1),3);IPsy(SCOREPAYS(4,1),3);IPsy(SCOREPAYS(5,1),3);IPsy(SCOREPAYS(6,1),3)},...
            'interet_psycho_Ideal', {IPsy(SCOREPAYS(1,1),4);IPsy(SCOREPAYS(2,1),4);IPsy(SCOREPAYS(3,1),4);IPsy(SCOREPAYS(4,1),4);IPsy(SCOREPAYS(5,1),4);IPsy(SCOREPAYS(6,1),4)},...
            'interet_eco_Risque', {IEco(SCOREPAYS(1,1),1);IEco(SCOREPAYS(2,1),1);IEco(SCOREPAYS(3,1),1);IEco(SCOREPAYS(4,1),1);IEco(SCOREPAYS(5,1),1);IEco(SCOREPAYS(6,1),1)},...
            'interet_eco_Convenable', {IEco(SCOREPAYS(1,1),2);IEco(SCOREPAYS(2,1),2);IEco(SCOREPAYS(3,1),2);IEco(SCOREPAYS(4,1),2);IEco(SCOREPAYS(5,1),2);IEco(SCOREPAYS(6,1),2)},...
            'interet_eco_Ideal', {IEco(SCOREPAYS(1,1),3);IEco(SCOREPAYS(2,1),3);IEco(SCOREPAYS(3,1),3);IEco(SCOREPAYS(4,1),3);IEco(SCOREPAYS(5,1),3);IEco(SCOREPAYS(6,1),3)})
            
            
for P=1:6 %on affiche les 6 premiers pays
    disp(resultat(P));
end;
