# Dependency installation

## Using sdkman
1. Install sdkman `curl -s "https://get.sdkman.io" | bash`
2. Install GraalVM 25 `sdk install java 25.0.1-graal`
3. Enable GraalVM 25 `sdk use java 25.0.1-graal`
4. Install binaryen `brew install binaryen`

## Using nix/direnv
Assuming you have your home environment setup to use nix and direnv already...
1. `direnv allow`

# Build instructions
1. Compile Java classes `javac -parameters -d target/classes src/browser/Callback.java src/browser/Browser.java`
2. Build wasm executable `clojure -M:native-image`

# Run the project
3. Start web server `python3 -m http.server 8000` 
4. Go to `http://localhost:8000/index.html` in your browser, press a button on the page, should see an alert
