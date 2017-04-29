#include <sourcemod>
#pragma semicolon 1
#pragma newdecls required

Menu m_NorthSideMenu;

public Plugin myinfo = 
{
	name        = "[NorthSide] Selection Menu",
	author      = "B3none",
	description = "Menu to allow use of all commands!",
	version     = "0.0.5",
	url         = "www.voidrealitygaming.co.uk"
};

static const char s_CommandList[][] =
{
	"sm_ws",
	"sm_knife",
	"sm_gloves",
	"sm_coin",
	"sm_music"
}; 

static const char s_TranslationList[][] =
{
	"Menu Title",
	"Weapon Skins",
	"Knife",
	"Gloves",
	"Pin",
	"Music"
}; 

public void OnPluginStart()
{
	LoadTranslations("northsidemenu.phrases");
	
	RegConsoleCmd("sm_ns", NorthSideMenu, "NorthSide Menu Command");
	RegConsoleCmd("sm_NS", NorthSideMenu, "NorthSide Menu Command");
	RegConsoleCmd("sm_northside", NorthSideMenu, "NorthSide Menu Command");
}
 
public int NorthSideHandler(Menu menu, MenuAction action, int client, int choice)
{
	switch(action)
	{
		case MenuAction_Select:
		{
			FakeClientCommand(client, "%s", s_CommandList[choice]);
		}
	}
	return 0;
}
 
Menu BuildNorthSideMenu()
{
	Menu menu = new Menu(NorthSideHandler, MENU_ACTIONS_ALL);
	menu.SetTitle("%T", s_TranslationList[0], LANG_SERVER);
	
	for(int i = 1; i <= sizeof(s_TranslationList); i++)
	{
		menu.AddItem("%T", s_TranslationList[i]);
	}
	
	menu.ExitButton = true;
	return menu;
}

public Action NorthSideMenu(int client, int args)
{
	if(0 < client <= MaxClients && IsClientInGame(client)) m_NorthSideMenu.Display(client, 20);
	return Plugin_Handled;
}

public void OnMapStart()
{
	m_NorthSideMenu = BuildNorthSideMenu();
}

public void OnMapEnd()
{
    if(m_NorthSideMenu != null)
    {
        delete(m_NorthSideMenu);
        m_NorthSideMenu = null;
    }
}
