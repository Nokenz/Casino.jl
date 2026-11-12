try; import KaimonSlate; catch; error("This is a Kaimon Slate notebook — running it as plain Julia needs the KaimonSlate runtime in this environment. Add it with `import Pkg; Pkg.add(\"KaimonSlate\")`, or open it in Kaimon Slate."); end; KaimonSlate.standalone!(@__MODULE__; dir=@__DIR__)

#%% md id=intro
@md"""
# New Notebook
"""

#%% code id=187732
using Casino

#%% code id=45bbef
using WGLMakie
joueur1=CrapsGamer(100,20)
#les boutons ne sont pas encore interractifs
figC=Figure()
btn1 = Makie.Button(figC[1,1], label="pass line", tellwidth=false)
btn2 = Makie.Button(figC[2,1], label="don't pass", tellwidth=false)
#ici faudra un moyen de donner le pari (entre 1 et 6 sur un lancer de des)
btn3= Makie.Button(figC[3,1], label="prop", tellwidth=false)
btn4= Makie.Button(figC[4,1],label="come", tellwidth=false)
btn5= Makie.Button(figC[5,1], label="don't come", tellwidth=false)

#%% code id=dad4d9
#gestion bouton pass line
#ne fonctionne pas encore 
if (btn1.clicks==true) then
    passline(a,joueur1)
    #pour voir le solde et la mise
    test1=Label(figC[6,1], joueur1)
end

#%% code id=54ffd1
WGLMakie.activate!()
figC
display(figC)

# ╔═╡ Slate.config · per-notebook settings (Settings panel)
#   docid = 94ba17ce-80e2-4afd-8610-97f415bfc05f
#   format = 2
# ╚═╡
