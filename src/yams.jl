mutable struct YamsGamer <: AbstractGamer
    nom::String
    solde::Float64
    nb_parties::Int
end


struct YamsGame <:AbstractGame
    des::Vector{Int}
    combinaison::String
    mise::Float64
    gain::Float64
end



function combinaison(des)
    freq = sort(collect(values(countmap(des))))

    if freq == [5]
        return "yams"

    elseif freq == [1,4]
        return "carre"

    elseif freq == [2,3]
        return "full"

    elseif  freq == [1,1,3]
        return "brelan"

    elseif freq == [1,2,2]
        return "double paire"

    elseif freq == [1,1,1,2]
        return "paire"

    else
        return "autre"
    end
end


#On assigne un multiplicateur à chaque figure, ces multiplicateurs ont été calculé de sorte à ce que l'espérance de gain soit proche de 0,9 pour simuler un jeu de casino réaliste
function multiplicateur(combinaison)
    if combinaison == "paire"
        return 0
    elseif combinaison == "double paire"
        return 1
    elseif combinaison == "brelan"
        return 2
    elseif combinaison == "full"
        return 5
    elseif combinaison == "carre"
        return 8
    elseif combinaison == "yams"
        return 40
    else
        return 0
    end
end

function gain(mise, combinaison)
    return mise * multiplicateur(combinaison)
end

#On utilise le multiple dispatching pour créer une fonction qui simule une partie de Yams avec ou sans Joueur
function jouer_yams(mise)

    # Vérifier que la mise est valide
    if mise <= 0
        throw(ArgumentError("La mise doit être positive"))
    end

    #Simule un lancé de 5 des
    des = rand(1:6, 5)


    comb = combinaison(des)
    montant = gain(mise, comb)

    return YamsGame(des, comb, mise, montant)
end

function jouer_yams(joueur::YamsGamer, mise::Real)

    # Vérifier que la mise est valide
    if mise <= 0
        throw(ArgumentError("La mise doit être positive"))
    end

    # Vérifier que le joueur a suffisamment d'argent
    if joueur.solde < mise
        throw(ArgumentError("Solde insuffisant"))
    end

    # Déduire la mise du solde
    joueur.solde -= mise

    # Jouer une partie avec la première méthode
    resultat = jouer_yams(mise)

    # Ajouter le gain au solde
    joueur.solde += resultat.gain

    # Incrémenter le nombre de parties
    joueur.nb_parties += 1

    return resultat
end

function simule_Yams(joueur::YamsGamer, nb::Int, mise::Real)

    historique = Float64[joueur.solde]

    for n in 1:nb

        if joueur.solde < mise
            println("Solde insuffisant, fin de la simulation.")
            break
        end

        jouer_yams(joueur, mise)

        push!(historique, joueur.solde)
    end

    return historique
end
