const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();
const logger = functions.logger;

exports.watchWordsUpdate = functions.region('europe-west3').firestore
  .document("users/{userId}/numbers/{numberId}/words/{wordId}")
  .onUpdate(async (change, context) => {
    try {
      const { userId, numberId, wordId } = context.params;

      const newValue = change.after.data();
      const previousValue = change.before.data();
      const isNewMainWord = newValue.is_main && !previousValue.is_main;

      if (isNewMainWord) {
        logger.info('Updating main word:', newValue.value);

        const userDocumentRef = admin.firestore().collection('users').doc(userId);
        const numberDocumentRef = userDocumentRef.collection('numbers').doc(numberId);
        const wordsCollectionRef = numberDocumentRef.collection('words');

        const batch = admin.firestore().batch();
        const wordsSnapshot = await wordsCollectionRef.get();
        wordsSnapshot.forEach(doc => {
          if (doc.id !== wordId && doc.data().is_main) {
            batch.update(doc.ref, { is_main: false });
          }
        });
        await batch.commit();

        await numberDocumentRef.update({
          main_word: newValue.value
        });
      }
    } catch (error) {            
      logger.error('Error updating main word:', error);
    }
    return null;
  });
