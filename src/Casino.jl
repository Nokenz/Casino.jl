module Casino

using StatsBase

#abstract types communs
abstract type AbstractGamer end
abstract type AbstractGame end

#Yams
export YamsGamer
export ResultatYams
export combinaison
export multiplicateur
export gain
export jouer_yams
export simule_Yams

include("yams.jl")

# Roulette
export RouletteGamer
export RouletteGame
export bet!
export rouge
export couleur
export parite
export manque_passe
export Pari
export verifier_pari
export prelever_mise
export pari_gagnant
export calculer_gain
export ajouter_gain
export jouer_roulette

include("roulette.jl")

#Craps
export AbstractGame
export AbstractGamer
export passline
export sumdes
export dontpass
export prop
export dontcome
export come



include("craps.jl")


end