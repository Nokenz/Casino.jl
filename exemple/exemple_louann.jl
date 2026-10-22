using Casino

#gains et mises a tester
a=sumdes()  #come out lancer (1er de la manche)

joueur1=CrapsGamer(100,20)
passline(a,joueur1)

#ResultatCraps()
dontpass(a,joueur1)

#entrer le pari
print("insérez votre pari: ")
prop(sumdes(),joueur1) #taper sur entrer 2 fois

come(a,joueur1)
dontcome(a,joueur1)