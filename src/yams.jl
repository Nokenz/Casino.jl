function lancer_des()
    return rand(1:6, 5)
end
#test push 

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

function lancer_jusqua_yams()
    i = 0

    while true
        i += 1
        des = lancer_des()

        if combinaison(des) == "yams"
            break
        end
    end

    return i
end