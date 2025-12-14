# Lista de usuarios de manutencao (sem dominio)
$manutencao = @('usuario1','usuario2','administrator')

# Captura saada do quser (ignora cabeçalho)
$sess = quser | Select-Object -Skip 1

# Inicializa lista de usuarios validos (nao manutencao)
$usuariosValidos = @()
$usuariosIgnorados = @()

foreach ($line in $sess) {
    if ($line.Trim() -eq '') { continue }

    # Limpa espacos duplicados, divide por espaco
    $parts = ($line -replace '\s{2,}', ' ').Trim().Split(' ')
    
    if ($parts.Count -ge 1) {
        # Remove ">" que marca o usuario atual
        $usuario = $parts[0].ToLower().Replace('>', '')

        if ($manutencao -contains $usuario) {
            $usuariosIgnorados += $usuario
        } else {
            $usuariosValidos += $usuario
        }
    }
}

# Remove duplicatas
$usuariosValidos = $usuariosValidos | Sort-Object -Unique
$usuariosIgnorados = $usuariosIgnorados | Sort-Object -Unique

# Conta de usuarios validos (nao manutencao)
$count = $usuariosValidos.Count

# Log de diagnostico
Write-Output "$(Get-Date):"
Write-Output "Usuarios Administradores: $($usuariosIgnorados -join ', ')"
Write-Output "Usuarios Ativos: $($usuariosValidos -join ', ')"
Write-Output "Total de Usuarios: $count"

# Se houver 3 ou mais usuarios validos, reinicia
if ($count -ge 3) {
    Write-Output "Reiniciando sistema. Limite de usuarios atingido."
    msg * /time:10 "ATENCAO: Reiniciando em 5 segundos. Excesso de usuarios logados."
    Start-Sleep -Seconds 7
    Restart-Computer -Force
}
