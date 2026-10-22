using Casino
using CairoMakie

Noé = YamsGamer("Noé", 1000.0, 0)

# Simulation de 100 parties
historique = simule_Yams(Noé, 100, 10.0)

# Création de la figure
fig = Figure(size = (900, 500))

# Création des axes
ax = Axis(
    fig[1, 1],
    xlabel = "Nombre de parties",
    ylabel = "Solde",
    title = "Évolution du solde Yams"
)

# Numéros des parties
x = 0:(length(historique)-1)

# Courbe du solde
lines!(ax, x, historique, label = "Solde du joueur", linewidth = 2)

# Ligne horizontale représentant le solde initial
hlines!(ax, [historique[1]], color = :red, linestyle = :dash,
        label = "Solde initial")

# Affichage de la légende
axislegend(ax)

# Affichage du graphique
display(fig)