export PassLine, sumdes, DontPass, prop

function sumdes()
v=rand(1:6, 2)
v=v[1]+v[2]
end

#a prends le 1er lancer de des
#b prends tous les lancers sur le point 
# PB le jeu sur le point(b) finctionne mal a priori
function PassLine(a) #pari le plus general du craps (facile de gagner)
if(a==7) || (a==11)
    print("gagné 1")
elseif (a==2)|| (a==3)||(a==12)
    print("perdu 1")
else
    #jeu sur le point
    print("point = ", a)

    b=sumdes()
    #while (b!=7)
    #   b=sumdes()
    #   print("des tirés",b)
    #end
    if (b==7)
    print(", 7 qui prend perdu 2")
    elseif (b==a)
    print("gagné au point 2")
    else 
    print("rien")
    end
end
end



function DontPass(a,b)  #pari don't pass (globalement l'opposé de passline)
if(a==7) || (a==11)
    print("perdu dp")
elseif (a==2)|| (a==3)
    print("gagné dp")
else
    #jeu sur le point
    print("point = ", a)
    if(b==7)
        print("point gagné sur le 7")
    end
end
end

function prop()  #pari proposition (chiffre precis)

end