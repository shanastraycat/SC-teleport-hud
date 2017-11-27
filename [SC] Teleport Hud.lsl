list loclist=["area1","area2","area3","area4"];//button name for teleport options
string sound="6005e358-33fd-d08b-012f-6110ab27a413"; // button click sound

key  owner; // owner
string version; // Hud version
integer gotTPperms; // Teleport Permission
string region; // Region Name
string  loc; // location to teleport to

teleport(integer num)
{
    llPlaySound(sound,1.0);
    loc= llGetInventoryName(INVENTORY_LANDMARK, num);
    if (loc =="" )
    {llOwnerSay("Landmark not available");}
    else
    {llTeleportAgent(owner, loc, ZERO_VECTOR, ZERO_VECTOR);}
}

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
    { if(owner==llDetectedKey(total_num))
       { 
        string name = llGetLinkName(llDetectedLinkNumber(0));
        { integer i=0;
          integer len = llGetListLength(loclist);
          while( i < len)
          {
            if(name == llGetObjectName()) {
                return;
            } else if(name == llList2String(loclist,i)) {
                teleport(i);
                return;
            }
            ++i;
          }
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
            {llOwnerSay("Please reattach hud and accept Teleport permission.");}
    }
}