<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Sistema Integral de Asistencia</title>
    <link rel="stylesheet" href="styles.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
</head>
<body class="login-page">
    <div class="login-container">
        <div class="login-box">
            <div class="login-header">
                <img src="/Sistema-Integral-de-Asistencias-SIA-/assets/logo/logo.png" alt="Logo SIA" class="login-logo">
                <h1>Sistema Integral de Asistencia</h1>
                <p>Centros Etnoeducativos</p>
            </div>
            <form class="login-form" action="procesar_login.php" method="POST">
                <div class="form-group">
                    <label for="email">Correo Electrónico</label>
                    <input type="email" id="email" name="email" required>
                </div>
                <div class="form-group">
                    <label for="password">Contraseña</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <button type="submit" class="login-button">Iniciar Sesión</button>
                <div class="login-footer">
                    <a href="#" class="forgot-password">¿Olvidaste tu contraseña?</a>
                    <a href="index.html" class="back-home">Volver al inicio</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
