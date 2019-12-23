public class Vaults.Application : Gtk.Application {

    public static GLib.Settings saved_state;

    static construct {
        saved_state = new GLib.Settings ("com.github.arkaitzsilva.vaults.saved-state");
    }

    public Application() {
        Object(
            application_id: Vaults.Configs.Constants.ID,
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate() {
		Vaults.Views.AppWindow app_window = new Vaults.Views.AppWindow(this);
		app_window.show();
    }

}
