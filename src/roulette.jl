 @enum BetType NumeroBet RougeBet NoirBet PairBet ImpairBet ManqueBet PasseBet

 @enum NumberResult RougeNumber NoirNumber PairNumber ImpairNumber  ManqueNumber PasseNumber ZeroNumber

 const RougeNumbers = [1,3,5,7,9,12,14,16,18,19,21,23,25,27,30,32,34,36]

struct RouletteGame <: AbstractGame
end


struct Pari
    numero::Int
    type_pari::BetType
    mise::Float64
end


struct RouletteResult
    numero::Int
    pari::Pari
    gain::Float64
end


mutable struct RouletteGamer <: AbstractGamer
    capital::Float64
    results::Vector{RouletteResult}
end





function bet!(roulette::RouletteGame, joueur::RouletteGamer, pari::Pari)
    pari_gagnant(pari, rand(roulette))
    prelever_mise(joueur, pari)
    joueur
end

 Base.rand((roulette::RouletteGame)) = rand(0:36)


function couleur(numero)
    if numero == 0
        return ZeroNumber
    elseif numero in RougeNumbers
        return RougeNumber
    else
        return NoirNumber
    end
end

function parite(numero)
    if numero == 0
        return ZeroNumber
    elseif iseven(numero)
        return PairNumber
    else
        return ImpairNumber
    end
end

function manque_passe(numero)
    if numero == 0
        return ZeroNumber
    elseif numero in 1:18
        return ManqueNumber
    else
        return PasseNumber
    end
end


function verifier_pari(pari::Pari, joueur::RouletteGamer)

    if pari.type_pari == NumeroBet && !(0 <= pari.numero <= 36)
        return false
     if !isfinite(pari.mise) || pari.mise <= 0
        return false
    elseif pari.mise > joueur.capital
        return false
    else
        println("Pari valide : $(pari.type_pari) avec une mise de $(pari.mise)€.")
        return true
    end
end

function prelever_mise(joueur::RouletteGamer, pari::Pari)
    if !verifier_pari(pari, joueur)
        return false
    else
        joueur.capital -= pari.mise
    return true
    end
end

function pari_gagnant(pari::Pari, numero::Int)
   
    if pari.type_pari == RougeBet &&  couleur(numero) == RougeNumber
        return true
    elseif pari.type_pari == NoirBet &&  couleur(numero) == NoirNumber
        return true
    elseif pari.type_pari == PairBet && parite(numero) == PairNumber
        return true
    elseif pari.type_pari == ImpairBet && parite(numero) == ImpairNumber
        return true
    elseif pari.type_pari == ManqueBet && manque_passe(numero) == ManqueNumber
        return true
    elseif pari.type_pari == PasseBet && manque_passe(numero) == PasseNumber
        return true
    else
        return false
    end
end

function calculer_gain(pari::Pari, numero::Int)
    if pari_gagnant(pari, numero)
        return pari.mise * 2
    else
        return 0.0
    end
    
end

function ajouter_gain(joueur::RouletteGamer, gain::Float64)
    joueur.capital = joueur.capital + gain
    return  joueur.capital
    println("Gain de $(gain)€ ajouté. Nouveau capital : $(joueur.capital)€.")
end

function jouer_roulette(joueur::RouletteGamer, pari::Pari)

    # prelever la mise
    prelever_mise(joueur, pari)
    
    # lancer la roulette
    numero = lancer_roulette()

    # calculer le gain
    gain = calculer_gain(pari, numero)

    # ajouter le gain au capital du joueur
    ajouter_gain(joueur, gain)

    # afficher le résultat du tour
    println("Numéro tiré : $(numero).")
    println("couleur : $(couleur(numero))")
    println("Parité : $(parite(numero))")
    println("Manque/Passe : $(manque_passe(numero))")


    if gain > 0
        println("Félicitations ! Vous avez gagné $(gain)€.")
    else
        println("Désolé, vous avez perdu votre mise de $(pari.mise)€.")
    end

    println("Capital restant : $(joueur.capital)€.")

end