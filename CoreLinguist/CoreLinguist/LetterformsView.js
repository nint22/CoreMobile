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
}

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
}

// All letterforms must derive from this form
"LetterformsViewController":
{
    // Form properties
    "Parent": "UIViewController",
    "ViewMode: "Scroll",
    
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
}

{
	“Form Title”:
	{
		"type":"Label",
		"Value":"Race car profile",
		"font":"Arial",
		"font-size":"20",
		"font-color":"#883431"
		"position":"188, 237",
		"size":"237, 34",
	},
	“Driver Image”:
	{
		"type":"Image",
		"Value":"DefaultImage.png",
		"position":"79, 169",
		"size":"110, 110",
	}
}