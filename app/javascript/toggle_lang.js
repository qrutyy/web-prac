
// toggle-lang.js
document.addEventListener('DOMContentLoaded', () => {
 const languageSwitch = document.getElementById('languageSwitch');
  const languageSwitchLabel = document.getElementById('languageSwitchLabel');

  // Translation data
  const translations = {
	  en: {
		  name: "Mikhail Gavrilenko",
		  short-desc: "Student of the System Programming department, SPbU",

    },
	  ru: {
		  name: "Михаил Гавриленко",
		  short-desc: "Студент кафедры Системного Программирования СПбГУ",
		  

    }
  };
 let currentLang = 'en'; // Default language
  updateLanguage();

  languageSwitch.addEventListener('change', () => {
    currentLang = languageSwitch.checked ? 'en' : 'ru';
    updateLanguage();
  });

	function updateLanguage() {
	document.getElementById('name').textContent = translations[currentLang].name;
	document.getElementById('short-desc').textContent = translations[currentLang]['short-desc'];

    // Update button text
    languageSwitchLabel.textContent = currentLang === 'en' ? 'Switch to Russian' : 'Switch to English';}
  });

});

