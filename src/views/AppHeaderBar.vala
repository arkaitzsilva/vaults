public class Vaults.Views.AppHeaderBar : Gtk.HeaderBar {
    public AppHeaderBar() {
        get_style_context().add_class("default-decoration");

        title = Vaults.Configs.Constants.PROGRAME_NAME;
        show_close_button = true;
    }
}

