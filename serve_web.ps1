$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:8080/")
$listener.Start()
Write-Host "Dabawenyos Flutter App is live at http://localhost:8080/"
Start-Process "http://localhost:8080/"

$webRoot = "c:\Users\user1\Projects\dabawenyos\build\web"

while ($listener.IsListening) {
    $context = $listener.GetContext()
    $request = $context.Request
    $response = $context.Response

    $path = $request.Url.LocalPath.TrimStart('/')
    if ([string]::IsNullOrEmpty($path)) {
        $path = "index.html"
    }

    $filePath = Join-Path $webRoot $path

    if (Test-Path $filePath -PathType Leaf) {
        $ext = [System.IO.Path]::GetExtension($filePath).ToLower()
        switch ($ext) {
            ".html" { $response.ContentType = "text/html" }
            ".js"   { $response.ContentType = "application/javascript" }
            ".mjs"  { $response.ContentType = "application/javascript" }
            ".json" { $response.ContentType = "application/json" }
            ".wasm" { $response.ContentType = "application/wasm" }
            ".css"  { $response.ContentType = "text/css" }
            ".png"  { $response.ContentType = "image/png" }
            ".jpg"  { $response.ContentType = "image/jpeg" }
            ".svg"  { $response.ContentType = "image/svg+xml" }
            default { $response.ContentType = "application/octet-stream" }
        }

        $bytes = [System.IO.File]::ReadAllBytes($filePath)
        $response.ContentLength64 = $bytes.Length
        $response.OutputStream.Write($bytes, 0, $bytes.Length)
        $response.OutputStream.Close()
    } else {
        $response.StatusCode = 404
        $response.OutputStream.Close()
    }
}
