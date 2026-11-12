try; import KaimonSlate; catch; error("This is a Kaimon Slate notebook — running it as plain Julia needs the KaimonSlate runtime in this environment. Add it with `import Pkg; Pkg.add(\"KaimonSlate\")`, or open it in Kaimon Slate."); end; KaimonSlate.standalone!(@__MODULE__; dir=@__DIR__)

#%% md id=intro
@md"""
# Mon notebook
"""

#%% code id=5dc8fa
import Pkg; Pkg.activate(".")

#%% code id=6dedab
using Casino

#%% code id=e36327
using WGLMakie

#%% code id=5bb643
function lancer_interface_yams(solde_depart=100.0)
    # 1. Initialisation du joueur
    joueur = YamsGamer("Joueur 1", solde_depart, 0)

    # 2. Création des Observables
    obs_solde = Observable(joueur.solde)
    obs_historique = Observable(Float64[joueur.solde])
    obs_dernier_lance = Observable([0, 0, 0, 0, 0])
    obs_message = Observable("Prêt à lancer les dés !")

    # 3. Création de la figure (élargie pour le côte à côte)
    fig = Figure(size = (1000, 600))

    # ==========================================
    # --- COLONNE GAUCHE : PANNEAU DE CONTRÔLE
    # ==========================================
    panneau_gauche = fig[1, 1] = GridLayout(tellwidth=true)

    # Zone 1 : Jouer 1 partie
    Makie.Label(panneau_gauche[1, 1], "Mise unitaire :", halign=:left)
    slider_mise = Makie.Slider(panneau_gauche[1, 2], range = 1:1:50, startvalue = 5, width=150)
    Makie.Label(panneau_gauche[1, 3], @lift("$($(slider_mise.value)) €"), halign=:left) 
    btn_jouer = Makie.Button(panneau_gauche[2, 1:3], label = "Jouer 1 partie", buttoncolor = :lightblue)

    # Zone 2 : Simuler N parties
    Makie.Label(panneau_gauche[3, 1], "Nb parties :", halign=:left)
    slider_n = Makie.Slider(panneau_gauche[3, 2], range = 10:5:50, startvalue = 10, width=150)
    Makie.Label(panneau_gauche[3, 3], @lift("$($(slider_n.value))"), halign=:left)
    btn_jouer_n = Makie.Button(panneau_gauche[4, 1:3], label = "Simuler N parties", buttoncolor = :lightgreen)

    # Zone 3 : Reset
    btn_reset = Makie.Button(panneau_gauche[5, 1:3], label = "Réinitialiser la partie", buttoncolor = :lightcoral)

    # Espace vide pour aérer entre les boutons et le texte
    Makie.Label(panneau_gauche[6, 1:3], "", height=20) 

    # Zone 4 : Affichage des résultats en direct
    Makie.Label(panneau_gauche[7, 1:3], @lift("Solde : $(round($(obs_solde), digits=2)) €"), fontsize = 24, font = :bold)
    Makie.Label(panneau_gauche[8, 1:3], @lift("Dés : $(join($(obs_dernier_lance), " - "))"), fontsize = 18)
    Makie.Label(panneau_gauche[9, 1:3], obs_message, fontsize = 16, color = :purple)


    # ==========================================
    # --- COLONNE DROITE : GRAPHIQUE 
    # ==========================================
    ax = Axis(fig[1, 2], 
              title = "Évolution du solde au fil du temps", 
              xlabel = "Nombre de parties jouées", 
              ylabel = "Solde (€)")
    
    lines!(ax, obs_historique, color = :blue, linewidth = 2)


    # ==========================================
    # --- LOGIQUE INTERACTIVE (Callbacks)
    # ==========================================
    on(btn_jouer.clicks) do _
        mise = slider_mise.value[]
        if joueur.solde >= mise
            resultat = jouerYams(joueur, mise)

            obs_dernier_lance[] = resultat.des
            obs_message[] = "Figure : $(resultat.combinaison) | Gain : $(resultat.gain) €"
            obs_solde[] = joueur.solde
            
            # Mise à jour du graphique avec notify
            push!(obs_historique[], joueur.solde)
            notify(obs_historique) # <-- INDISPENSABLE
            autolimits!(ax)
        else
            obs_message[] = "❌ Solde insuffisant pour miser $(mise) € !"
        end
    end

    on(btn_jouer_n.clicks) do _
        try
            # 1. Conversion stricte pour s'adapter à la signature `nb::Int` et `mise::Real`
            mise = Float64(slider_mise.value[])
            n = Int(slider_n.value[])

            # 2. Appel de ta fonction
            historique_sim = rand(joueur, n, mise)

            if length(historique_sim) > 1
                obs_solde[] = joueur.solde
                obs_message[] = "Simulation de $(length(historique_sim)-1) parties terminée."
                obs_dernier_lance[] = [0,0,0,0,0] # On cache les dés

                # 3. Mise à jour du graphique
                append!(obs_historique[], historique_sim[2:end])
                notify(obs_historique)
                autolimits!(ax)
            else
                obs_message[] = "❌ Solde insuffisant pour lancer la simulation !"
            end
        catch e
            # 4. Si une erreur survient (MethodError, faute de frappe, etc.), 
            # elle s'affichera directement en texte violet dans ton interface !
            obs_message[] = "Erreur : $(e)"
            println("Erreur de simulation: ", e) # Pour l'avoir aussi dans la console
        end
    end

    on(btn_reset.clicks) do _
        joueur.solde = solde_depart
        joueur.nb_parties = 0

        obs_solde[] = solde_depart
        obs_historique[] = [solde_depart]
        obs_dernier_lance[] = [0,0,0,0,0]
        obs_message[] = "Prêt à lancer les dés !"
        autolimits!(ax)
    end

    return fig
end

#%% code id=b814c5
WGLMakie.activate!()
fig = lancer_interface_yams(100.0)
display(fig)

#%% code id=ea3919
Noé = YamsGamer("Noé", 1000.0, 0)

# Simulation de 100 parties
historique = rand(Noé, 100, 10.0)

# ╔═╡ Slate.config · per-notebook settings (Settings panel)
#   docid = 349d6240-7636-4e8e-bb5f-f2e82b54fc8a
# ╚═╡
