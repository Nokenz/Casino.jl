mutable struct CrapsGamer <: AbstractGamer
    capital :: Int
    mise::Int
end

mutable struct ResultatCraps
    bet::Int
    sumd::Int 
    res::String   
end

struct CrapsGame <:AbstractGame end

#Base.rand((lanceur::CrapsGame))

function sumdes()
v=rand(1:6, 2)
sumd=v[1]+v[2]
return sumd
end

function lanceurcraps()
b=sumdes()
return b
end

#a prends le 1er lancer de des
#b prends tous les lancers sur le point
#pari le plus general du craps (facile de gagner)
function passline(a::Int,gamer:: AbstractGamer)
 bet=1
if(a==7) || (a==11)
    #gagné
    ResultatCraps.sumd=a
    gamer.capital = gamer.capital + gamer.mise #puisqu'on a pas enlevé la mise avant
    res="gagné"
elseif (a==2)|| (a==3)||(a==12)
    #perdu
    gamer.capital= gamer.capital - gamer.mise
    res="perdu"
else
    #jeu sur le point
    res="neutre"  #sans ca la fonction beugue
    sumd=a

    b=lanceurcraps()
    while (b!=7) & (b!=a)
       b=sumdes()
        if(b==a)
        res="gagne au point"
        #gagné  #joueur reprends sa mise donc pas de changement de capital 
        elseif (b==7)
        #perdu 7 qui prend
        gamer.capital=gamer.capital-gamer.mise
        res="perdu"
        end
    
    end
end
return gamer, bet, res
end

#même fonctionnement que passLine en inversé
function dontpass(a::Int,gamer:: AbstractGamer)  #pari don't pass
bet=2
    if(a==7) || (a==11)
    #perds la mise
    gamer.capital=gamer.capital-gamer.mise
    res="perdu"
elseif (a==2)|| (a==3)
    #gagne ce que tu as mise
    gamer.capital=gamer.capital + gamer.mise
    res="gagné"
elseif(a==12)
    #reprends la mise
    res="fin de manche"
else
    #joue sur le point
   #ResultatCraps.sumd=a

    b=lanceurcraps()
    while (b!=7) & (b!=a)
       b=sumdes()
        if(b==a)
          #perds la mise
          res="perdu"
        gamer.capital=gamer.capital-gamer.mise
        elseif (b==7)
          #gagne la mise 
        gamer.capital=gamer.capital+gamer.mise
        res="gagné"
        else 
        #relance le de
        end
    end 
    #sumd=a
end
return gamer, bet ,res
end

#pari proposition (chiffre precis) sur un lancer
function prop(x,gamer:: AbstractGamer)  
bet=3
s=readline()  
print("lancer= ",x)
if(x==s)
   #gagne ta mise 
  gamer.capital=gamer.mise*30
  res="gagné"
else
    gamer.capital=gamer.capital-gamer.mise
    res="perdu"
end
return gamer, bet, res
end

#comme passline mais a placer n'importe quand
function come(a::Int,gamer:: AbstractGamer) 
bet=4
if(a==7) || (a==11)
    gamer.capital=gamer.capital+gamer.mise
    res="gagné"
elseif (a==2)|| (a==3)||(a==12)
    #preds la mise
    gamer.capital=gamer.capital-gamer.mise
    res="perdu"
else
    #jeu sur le point
    ResultatCraps.sumd=a

    b=lanceurcraps()
    while (b!=7) & (b!=a)
       b=sumdes()
        if(b==a)
        #gagne ta mise
        gamer.capital=gamer.capital+gamer.mise
        res="gagné"
        elseif (b==7)
        #perdu
        gamer.capital=gamer.capital-gamer.mise
        res="perdu"
        else 
        #relance
        end
   ResultatCraps.sumd
    end
end
return gamer, bet, res
end

#comme dontpass mais a placer n'import quand
function dontcome(a::Int,gamer:: AbstractGamer)
bet=5
if(a==7) || (a==11)
    #perdu
    gamer.capital=gamer.capital-gamer.mise
    res="perdu"
elseif (a==2)|| (a==3)
    #gagne ta mise
    gamer.capital=gamer.capital+gamer.mise
    res="gagné"
elseif(a==12)
    #reprends ta mise
    res="neutre"
else
   ResultatCraps.sumd=a

    b=lanceurcraps()
    while (b!=7) & (b!=a)
       b=sumdes()
        if(b==a)
       #perdu au point
        gamer.capital=gamer.capital-gamer.mise
        res="perdu"
        elseif (b==7)
        #gagne ta mise
        gamer.capital=gamer.capital+gamer.mise
        res="gagné"
       # else 
        #relance
        end
    end 
end
return gamer, bet, res
end