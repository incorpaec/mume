from flask import Flask
import subprocess
import os

app = Flask(__name__)

@app.route("/")
def home():
    return "Android Automation Server Running"

@app.route("/devices")
def devices():
    try:
        result = subprocess.check_output(["adb", "devices"]).decode()
        return f"<pre>{result}</pre>"
    except Exception as e:
        return str(e)

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host="0.0.0.0", port=port)
