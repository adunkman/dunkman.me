const { passcode } = require("./auth.config.json");
const cookieName = "token";
const encodedPasscode = Buffer.from(passcode).toString('base64');

exports.handler = async (event) => {
    const { request } = event.Records[0].cf;
    const qs = new URLSearchParams(request.querystring || "");
    const cookieValue = ((request.headers.cookie || [])[0] || {}).value || "";

    if (qs.get("code") === passcode) {
      // return a redirect to strip the code from the querystring and add it
      // as a cookie if authorized via embedded QR code
      return {
        status: "302",
        headers: {
          "location": [{ value: request.uri }],
          "set-cookie": [{ value: `${cookieName}=${encodedPasscode}; HttpOnly; Path=/` }]
        }
      };
    }

    if (cookieValue.includes(`${cookieName}=${encodedPasscode}`)) {
      // allow the request to proceed interrupted if the cookie is present
      return request;
    }

    // request the passcode via login screen
    return {
      status: "200",
      body: `
        <!DOCTYPE html>
        <html lang="en-us">
          <head>
            <title>Log in • Andrew Dunkman</title>
            <meta charset="utf-8">
            <meta name="referrer" content="origin">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <meta name="description" content="Enter your credentials to log in">
            <meta name="robots" content="noindex, nofollow">
            <style>

              html {
                box-sizing: border-box;
                font-family: Helvetica, Arial, sans-serif;
                font-kerning: normal;
                font-feature-settings: 'kern' 1;
                line-height: 1.5;
                text-rendering: optimizeLegibility;
                min-height: 100vh;
                background-color: #112f4e;
                color: #fff;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
              }
              *,
              *::before,
              *::after {
                box-sizing: inherit;
              }
              body {
                width: 100%;
                max-width: 50ch;
                animation: dialog-slide-up 0.3s ease;
              }
              img {
                display: block;
                margin: 0 auto 2rem;
              }
              main {
                margin: 1rem;
                padding: 2rem;
                background-color: #fff;
                border-radius: 0.5rem;
                color: rgba(0, 0, 0, 0.9);
                position: relative;
              }
              main::before {
                display: block;
                content: '';
                width: 1rem;
                height: 1rem;
                position: absolute;
                top: -1rem;
                left: 50%;
                transform: translateX(-50%);
                border-left: .5rem transparent solid;
                border-right: .5rem transparent solid;
                border-bottom: .5rem #fff solid;
              }
              label {
                display: inline-block;
                margin-bottom: .5rem;
              }
              input {
                display: block;
                background-color: #fff;
                appearance: none;
                font-size: 1rem;
                font-family: inherit;
                font-weight: normal;
                line-height: inherit;
                border: 1px rgba(0, 0, 0, 0.3) solid;
                border-radius: 0.2rem;
                padding: 0.5rem 0.7rem;
                color: rgba(0, 0, 0, 0.9);
                box-shadow: inset 1px 1px 1px 0px rgba(0, 0, 0, 0.05);
                width: 100%;
                margin-bottom: 1.2rem;
              }
              button {
                appearance: none;
                display: inline-block;
                cursor: pointer;
                text-decoration: none;
                font-size: 1rem;
                font-family: inherit;
                font-style: normal;
                font-weight: bold;
                line-height: inherit;
                border: 1px transparent solid;
                border-radius: 0.2rem;
                padding: 0.5rem 0.7rem;
                transition: background-color 0.04s ease-out;
                color: rgba(255, 255, 255, 0.9);
                background-color: rgb(62, 82, 228);
              }
              button:hover {
                background-color: #2491ff;
              }
              button:active {
                background-color: #005ea2;
              }
              .cancel-link {
                display: inline-block;
                margin-left: 1rem;
                color: rgba(0, 0, 0, 0.5);
              }
              .notice {
                background-color: #e8f5ff;
                padding: 0.5rem 0.7rem;
                margin-bottom: 1.5rem;
                border-radius: .2rem;
                border: 1px #cfe8ff solid;
              }
              @keyframes dialog-slide-up {
                0% {
                  opacity: 0;
                  transform: translateY(10px);
                }
                100% {
                  opacity: 1;
                  transform: translateY(0);
                }
              }
            </style>
          </head>
          <body>
            <img width="64" height="64" alt="Cartoon drawing of Andrew Dunkman" src="data:image/png;base64,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">
            <main>
              ${qs.get("code") ? `<div class="notice">That passcode is incorrect.</div>` : ""}
              <form>
                <label for="code">Enter your passcode to log in:</label>
                <input type="password" name="code" id="code">
                <button>Log in</button>
                <a href="/" class="cancel-link">Cancel</a>
              </form>
            </main>
          </body>
        </html>
      `
    }
}
