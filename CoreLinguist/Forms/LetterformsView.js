
// This is a revserve key-word, and anything inside can be refered to by any other file
"Import": ["MyFile.js"],

// My custom view controller
"MyView": {
    
    // This is a root view, so we don't have to define it explicitly
    
    // A generic header view
    "LetterformsHeader":
    {
        // Object type
        "Parent": "UIImage",
        
        // Object properties
        "Image": "Header.png",
        "Layout": "Stacked",
        
        // Fill type
        "Scale": "AspectFit",
        "Resize": "FillWidth"
    },

    // A generic footer
    "LetterformsFooter":
    {
        // Object type
        "Parent": "UIImage",
        
        // Object properties
        "Image": "Footer.png",
        "Layout": "Stacked",
        
        // Fill type
        "Scale": "AspectFit",
        "Resize": "FillWidth"
    },
    
    // All letterforms must derive from this form
    "LetterformsViewController":
    {
        // Form properties
        "Parent": "UIViewController",
        "ViewMode": "Scroll",
        
        // Include header
        "UIView": "LetterformsHeader",
        
        // Big letter we want to show
        "TopLetter":
        {
            // Object type
            "Parent": "UILabel",
            
            // Object properties
            "Text": "Æ",
            "Font": "Times New Roman",
            "Size": "24",
            "Alignment": "Center",
            
            // Position
            "Layout": "Relative, center",
            "top": "-50"
        }
        
        // Bottom
        "UIView": "LetterformsFooter",

    },

    /*** Sanity Check ***/

    // Test...

}

// Another test!