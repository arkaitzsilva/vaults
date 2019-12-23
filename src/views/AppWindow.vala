public class Vaults.Views.AppWindow : Gtk.ApplicationWindow {
    public AppHeaderBar header_bar { get; private set; }
    public AppView app_view { get; private set; }

    public AppWindow(Gtk.Application application) {
        Object(
        	application: application
        );
    }

    construct {
        build_window();
    }

    private void build_window() {
        load_common_elements();

        app_view = new AppView();
        //app_view.settings_sidebar.footer.add_vault_button.clicked.connect(() => {
            /*if(this.create_vault_dialog == null) {
			    this.create_vault_dialog = new CreateVaultDialog(this);
			    this.create_vault_dialog.show_all();

			    this.create_vault_dialog.destroy.connect(() => {
				    this.create_vault_dialog = null;
			    });

                this.create_vault_dialog.response.connect((source, response_id) => {
                    switch(response_id) {
                        case CreateVaultDialog.Action.CANCEL:
			                source.destroy();
			                break;
		                case CreateVaultDialog.Action.CREATE:
			                //mount_vault(((CreateVaultDialog)source).vault_basedir_entry.text, (CreateVaultDialog)source).vault_mountdir_entry.text);
                            //add_vault_to_list(source);
			                break;
                    }
                });

                this.create_vault_dialog.vault_basedir_browse_button.clicked.connect(() => {

                });

                this.create_vault_dialog.vault_mountdir_browse_button.clicked.connect(() => {

                });
		    }*/
        //});
        add(app_view);

        // Window events
        delete_event.connect(e => {
           return before_destroy();
        });
    }

	// Save window parameters before close it
    private bool before_destroy() {
        int x, y, width, height;

        get_size(out width, out height);
        get_position(out x, out y);

        Vaults.Application.saved_state.set("window-size", "(ii)", width, height);
        Vaults.Application.saved_state.set("window-position", "(ii)", x, y);

        return false;
    }

    private void load_common_elements() {
        // Load window parameters from settings
        int x, y, width, height;

        Vaults.Application.saved_state.get ("window-size", "(ii)", out width, out height);
        Vaults.Application.saved_state.get ("window-position", "(ii)", out x, out y);

        set_default_size(width, height);
        move(x, y);
    }

}
