# Account
### CustLogIn:
As Peter(a customer), I would like to log in with my correct username and password, so that I can access my account to get more precise navigation.
- CoS: when the input username and password match, allow the user to sign in.
- CoS: if the input username and password do not match, the user will get a notification that their username or password is incorrect. 
- Related persona: Peter Walker
### CustLogOut:
As Peter(a customer), I would like to log out of my account when I want, so that I can prevent my personal information from being seen by others.
- CoS: when the log out button is clicked, log out and go to the general page.
- Related persona: Peter Walker 
### CustSignUp:7
As Peter(a customer), I would like to create a new account if I don't have one, so that I can get navigations to assist me to make a shopping. 
- CoS: new account information (username and password) is saved in the backend database, account created.
- Related persona: Peter Walker
### CustProfile:
As Peter(a customer), I would like to modify my profile and settings, so that I can update my address information and modify my preferences. 
- CoS: profile and setting information are updated in the backend database. 
- Related persona: Peter Walker
# Company
### CompanyLogIn:
As Charles(a company manager), I would like to log in with my correct username and password, so that I can get permission to change the store information.
- CoS: organization and company login information are stored in the backend. 
- CoS: when user input is correct, allow him/her to log into the company account.
- Related persona: Charles Brown
### CompanyLogOut:
As Charles(a company manager), I would like to log out of my account when I leave the app or when I want, so that I can get a record of what I have modified and prevent company information from leaking.
- CoS: when the logout button is clicked, log out and return to the general page. 
- Related persona: Charles Brown
### CompanySignUp:
As Charles(a company manager), I would like to sign up for a new account if I don't have one, so that I can post my store information on the app.
- CoS: new company account information(username and password) is stored in the backend database, account created.
- Related persona: Charles Brown
### CompanyProfile:
As Charles(a company manager), I would like to modify my profile and settings, so that I can update the store’s information about the address, contact phone number, and description. 
- CoS: company profile and setting information are updated in the backend database.
- Related persona: Charles Brown
# Interface and Functions
### CustAddItem:
As Peter(a customer), I would like to add item to my grocery list to get a list of what to buy, so that I can manage my grocery list.
- CoS: The user's grocery list interface has added one item and transferred its item code to the backend. 
- Related persona: Peter Walker
### CustDeleteItem:
As Peter(a customer), I would like to delete the item I don't want, so that I can manage my grocery list. 
- CoS: The user's grocery list interface has deleted one item and sent a delete message to the backend. 
- Related persona: Peter Walker
### CustCheckItem:
As Peter(a customer), I would like to see what is currently in my grocery list, so that I can keep track of what is left and what has been done.
- CoS: The user can see the grocery list if they click the cart icon.
- Related persona: Peter Walker
### FilterByItem:
As Peter(a customer), I would like to get details of some specific items based on some limitations, so that I can get a list of all possible choices I can take and detailed information about the items. 
- CoS: The user can get a list of items with the keywords or limitations he or she gives. 
- Related persona: Peter Walker
### RouteByPath:
As Peter(a customer), I would like to get a plan of how to get all items in my grocery with the shortest physical path, so that I don’t have to move much to buy things on my grocery list. 
- CoS: A simulated route is created
- Cos: The user will be informed of the length of the route and can click on the route to start navigation.
- Cos: The user can ask for redesign by adjusting the given route or changing their preferences.
- Related persona: Peter Walker
### RouteByPrice:
As Peter(a customer), I would like to get a plan of how to get all items in my grocery at the lowest price, so that I can buy things on my grocery list at a good price.
- CoS: A simulated route is created
- Cos: The user will be informed of the total price if he or she follows the route and can click on the route to start navigation.
- Cos: The user can ask for redesign by adjusting the given route or changing their preferences.
- Related persona: Peter Walker
### RouteByStore:
As Peter(a customer), I would like to get a plan of how to get all items in my grocery in some specific stores, so that I can buy things on my grocery list in stores I like and trust.
- CoS: A simulated route is created
- Cos: The user will be informed of the limits of the store when designing the route and can click on the route to start navigation.
- Cos: The user can ask for redesign by adjusting the given route or changing their preferences.
- Related persona: Peter Walker
### UpdateItem:
As Charles(a company manager), I would like to edit item information in the database with the permission of an administrator, so that I can update its latest information.
- CoS: A item's information is updated under the company account.
- CoS: The item and its information ask to be updated in the backend database.
- CoS: All users can view the updated items.
- Related persona: Charles Brown
### CreateItem:
As Charles(a company manager), I would like to add the information about the price, location, and description of a new item to the database with the permission of an administrator, so that I can inform customers we get new products. 
- CoS: A new item and its information are posted under the company account.
- CoS: The item and its information ask to be created in the backend database.
- CoS: All users can view the new items.
- Related persona: Charles Brown
### DeleteItem:
As Charles(a company manager), I would like to delete the information about the price, location, and description of an existing item in the database with the permission of an administrator, so that I can inform customers we no longer provide this item. 
- CoS: A item and its information are deleted under the company account.
- CoS: The item and its information ask to be deleted in the backend database.
- CoS: All users are not able to view the deleted items.
- Related persona: Charles Brown
### CheckItem:
As Joan Green(the administrator), I would like to check the modified information about the price, location, and description of an item in the database before displaying that to the customers, so that I can secure the information on the app is reliable. 
- CoS: If the request to change the information is refused by the administrator, the modifier will get a notification about it. 
- CoS: If the request to change the information is accepted by the administrator, the backend database will modify as the wanted(update, create, delete). 
- Related persona: Joan Green
### MakeMap:
As Joan Green(the administrator), I would like to make a map based on information the company provides to the database, so that users can find specific locations, prices, and descriptions of items in that company.
- CoS: The users can choose items and check their details by clicking them on the map UI.
- Related persona: Joan Green
### AppUI:
As Joan Green(the administrator), I would like to make a layout to navigate the users, so that they can get proper instructions during the use.
- CoS: The users can get instructions when they need help operating the app. 
- Related persona: Joan Green