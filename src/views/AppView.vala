public class Vaults.Views.AppView : Gtk.Paned {

    public Gtk.Stack stack { get; private set; }
    //public Vaults.Views.Sidebar settings_sidebar { get; private set; }

    construct {
        build_ui();
    }

    private void build_ui() {
        stack = new Gtk.Stack();

        //settings_sidebar = new Vaults.Views.Sidebar(stack);

        //add(settings_sidebar);
        add(stack);
    }
	
}
