from flask import Flask
import subprocess

app = Flask(__name__)

@app.route("/")
def home():
    return "Android Automation Server Running"

@app.route("/devices")
def devices():
    result = subprocess.check_output(["adb", "devices"]).decode()
    return f"<pre>{result}</pre>"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)