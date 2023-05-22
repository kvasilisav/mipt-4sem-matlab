function L = d(mesh)

    Dx = c(mesh);
    Dy = b(mesh);
    
    L = Dx*Dx + Dy*Dy;
end