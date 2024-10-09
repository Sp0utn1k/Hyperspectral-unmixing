# Flask Server for RGBW Control

This repository contains the Flask backend that controls an RGBW lighting system via HTTP requests. It allows clients (such as a web-based frontend) to:

-   Send immediate RGBW values to the lighting system.
-   Schedule multiple lighting sequences with configurable durations and RGBW steps.
-   Monitor the current status of the RGBW system (last sent value, sequence status).

## Features

-   **Immediate RGBW control:** Send RGBW values that are applied immediately, interrupting any ongoing sequences.
-   **Lighting sequences:** Define sequences with multiple steps and durations, scheduled to run at specific times.
-   **Status monitoring:** Check the current status of the RGBW system (ongoing sequence, last sent value).
-   **Automated deployment:** Automatically deploy and update the Flask backend using Git with a post-receive hook.

___

## Setup Instructions

Follow this step-by-step guide to set up the Flask server on your Raspberry Pi.

### 1\. **Clone the Repository**

On your local development machine, clone the `flask_server` repository:

```bash
git clone https://your-git-server/flask_server.git
```

### 2\. **Set Up the Bare Repository on the Raspberry Pi**

1.  SSH into your Raspberry Pi:
