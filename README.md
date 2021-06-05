# Chicken Tender Subs on Sale
This is an open source copy of the Chicken Tender Subs on Sale code, with personal components (such as the key to the database) redacted from the code.

See the published app on the Google Play Store:
https://play.google.com/store/apps/details?id=com.brahapps.chickentendersubsonsale&hl=en_US&gl=US

## What does it do?
1. Allows the user to check for chicken tender sub sales in the app.
2. Notifies the user of any new sales when they begin.

## How does it work?
1. A firebase database stores a single value: is_sale (which is 'true' if there is currently a sale, and 'false' if there isn't.)
2. A Raspberry Pi runs the `/scripts/RUNME.py` script once every day. This script checks for a sale on Publix' website, and updates the database as necessary. It also sends a notification to users on the first day of a sale.
3. The app checks the database when the app's "Check" button is pressed, and will send the user to a website where you can order a sub.

## How can I compile and run the code?
1. For the scripts, you need to install ChromeDriver (https://chromedriver.chromium.org/), and add the installation to your system's PATH variable.
   - The ChromeDriver is used by the Raspberry Pi to open the Publix website and click-through the prompts. This is so we can get to the actual page that tells us if there is an ongoing sale.
   - After installing ChromeDriver, you can run the RUNME.py script with `python3 RUNME.py`
2. For the flutter app, you will need to create a new flutter project in Android Studio, then add the Dart files in `/flutter_app/src/` to the project's `/lib/` directory. 
3. Additionally, you will need to create your own firebase database, and adjust the code as necessary to use it.
 
