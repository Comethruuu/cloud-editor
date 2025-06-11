local notifyStyle = {
    backgroundColor = '#141517',
    color = '#C1C2C5',
    ['.description'] = {
        color = '#909296'
    }
}

local function showNotification(id, description)
    lib.notify({
        id = id,
        title = 'Rockstar Editor',
        description = description,
        position = 'top',
        style = notifyStyle,
    })
end

lib.registerMenu({
    id = 'editor',
    title = '☁️ Cloud Rockstar Editor ☁️',
    position = 'bottom-right',
    options = {
        {label = 'Record',    args = {id = 'record'}},
        {label = 'Save Clip', args = {id = 'save'}},
        {label = 'Delete Clip', args = {id = 'discard'}},
        {label = 'Enter Rockstar Editor', args = {id = 'gointo:editor'}}
    }
}, function(selected, scrollIndex, args)
    if args and args.id then
        TriggerEvent(args.id)
    end
    print(selected, scrollIndex, args)
end)

RegisterCommand('editor', function()
    lib.showMenu('editor')
end, false)

RegisterKeyMapping('editor', 'Open Rockstar Editor Menu', 'keyboard', 'F7')

RegisterNetEvent("record", function()
    StartRecording(1)
    showNotification('record_notify', 'Recording started.')
end)

RegisterNetEvent("save", function()
    StartRecording(0)
    StopRecordingAndSaveClip()
    showNotification('save_notify', 'Clip saved.')
end)

RegisterNetEvent("discard", function()
    StopRecordingAndDiscardClip()
    showNotification('discard_notify', 'Clip discarded.')
end)

RegisterNetEvent("gointo:editor", function()
    local alert = lib.alertDialog({
        header = 'Rockstar Editor',
        content = 'Press confirm to leave the server and go to Rockstar Editor',
        centered = true,
        cancel = true
    })
    if alert == 'confirm' then
        NetworkSessionLeaveSinglePlayer()
        ActivateRockstarEditor()
    end
end)
