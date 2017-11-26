
// owner
key  owner;
integer gotTPperms;

string loc1="area1";
string loc2="area2";
string loc3="area3";
string loc4="area4";

string sound="6005e358-33fd-d08b-012f-6110ab27a413";
integer gListener;    

key userid ;
string version;

string region;
string  loc;


default
{
    state_entry()
    {
        llPreloadSound(sound);
        region = llGetRegionName();
        owner = llGetOwner();
        version = llGetObjectDesc();
        gotTPperms = FALSE;
        
        llRequestPermissions(owner, (PERMISSION_TELEPORT | PERMISSION_TAKE_CONTROLS));
        
    }
    
    changed(integer change)
    {
        if (change & (CHANGED_OWNER | CHANGED_INVENTORY))
            llResetScript();
    }
    
    attach(key attached)
    {
        if (attached != NULL_KEY)
            llResetScript();
    }
 

     touch_start(integer total_num)
    {
       
        string name = llGetLinkName(llDetectedLinkNumber(0));
        {
        if(name == llGetObjectName()) {
            return;
        } else if(name == loc1) {
            llPlaySound(sound,1.0);
            loc= llGetInventoryName(INVENTORY_LANDMARK, 0);
            llTeleportAgent(owner, loc, ZERO_VECTOR, ZERO_VECTOR);
        }
        else if(name == loc2) {
            llPlaySound(sound,1.0);
            loc = llGetInventoryName(INVENTORY_LANDMARK, 1);
            llTeleportAgent(owner, loc, ZERO_VECTOR, ZERO_VECTOR);
        }
         else if(name == loc3) {
            llPlaySound(sound,1.0);
            loc = llGetInventoryName(INVENTORY_LANDMARK, 2);
            llTeleportAgent(owner, loc, ZERO_VECTOR, ZERO_VECTOR);
        }
        else if(name == loc4) {
            llPlaySound(sound,1.0);
            loc = llGetInventoryName(INVENTORY_LANDMARK, 3);
            llTeleportAgent(owner, loc, ZERO_VECTOR, ZERO_VECTOR);
        }
        }
    }
    

    
    control(key id,integer held, integer change)
    {
        return;
    }
    
    
     run_time_permissions(integer perm)
    {
        if (perm & PERMISSION_TAKE_CONTROLS)
            llTakeControls(CONTROL_UP,TRUE,TRUE);
        if (perm & PERMISSION_TELEPORT)
            {gotTPperms = TRUE;}
        else
        {llOwnerSay("Please reattach hud and accept Teleport permission.");
        }
    }

}
