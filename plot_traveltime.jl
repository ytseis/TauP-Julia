using CairoMakie, JSON
function plot_traveltime!(ax; phase, model, x, y, xminmax, yminmax, lw, ls, color)
    cmd = `taup curve --ph $phase --mod $model -x $x -y $y --xminmax $(xminmax[1]) $(xminmax[2]) --yminmax $(yminmax[1]) $(yminmax[2]) --json --output tmp_curve.json`
    run(cmd)
    doc = JSON.parsefile("tmp_curve.json")

    for curve in doc["curves"]
        label = curve["label"]
        segments = curve["segments"]
        for segment in segments
            lines!(ax, segment["x"], segment["y"], label=label, linewidth=lw, alpha=.5,
                linestyle=ls,
                color=color
            )
        end
    end
end
