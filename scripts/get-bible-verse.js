void (async function getRandomBibleVerse() {
  const response = await fetch(
    "https://labs.bible.org/api/?passage=random&type=json"
  );
  const data = await response.json();

  if (data && data.length > 0) {
    const verse = data[0];
    const { bookname, chapter, verse: verseNum, text } = verse;

    if (text.length >= 50) {
      const shortText = text.slice(0, 50).trim() + "...";
      console.log(`${bookname} ${chapter}:${verseNum} - "${shortText}"`);
    } else {
      console.log(`${bookname} ${chapter}:${verseNum} - "${text.trim()}"`);
    }
  } else {
    console.log("Hey, I guess it's time you pick the Bible fr.");
  }
})();
