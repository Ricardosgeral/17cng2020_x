#ifndef SPEAKER_HPP_
#define SPEAKER_HPP_

#include <QObject>
#include <qvariant.h>
#include <QQmlListProperty>
#include <QStringList>


#include "SpeakerImage.hpp"
// forward declaration (target references to this)
class Session;
#include "Conference.hpp"


class Speaker: public QObject
{
	Q_OBJECT

	Q_PROPERTY(int speakerId READ speakerId WRITE setSpeakerId NOTIFY speakerIdChanged FINAL)
	Q_PROPERTY(bool isDeprecated READ isDeprecated WRITE setIsDeprecated NOTIFY isDeprecatedChanged FINAL)
	Q_PROPERTY(QString sortKey READ sortKey WRITE setSortKey NOTIFY sortKeyChanged FINAL)
	Q_PROPERTY(QString sortGroup READ sortGroup WRITE setSortGroup NOTIFY sortGroupChanged FINAL)
	Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged FINAL)
	Q_PROPERTY(QString publicName READ publicName WRITE setPublicName NOTIFY publicNameChanged FINAL)
	Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged FINAL)
	Q_PROPERTY(QString bio READ bio WRITE setBio NOTIFY bioChanged FINAL)
	// speakerImage lazy pointing to SpeakerImage* (domainKey: speakerId)
	Q_PROPERTY(int speakerImage READ speakerImage WRITE setSpeakerImage NOTIFY speakerImageChanged FINAL)
	Q_PROPERTY(SpeakerImage* speakerImageAsDataObject READ speakerImageAsDataObject WRITE resolveSpeakerImageAsDataObject NOTIFY speakerImageAsDataObjectChanged FINAL)

	// QQmlListProperty to get easy access from QML
	Q_PROPERTY(QQmlListProperty<Session> sessionsPropertyList READ sessionsPropertyList NOTIFY sessionsPropertyListChanged)
	// QQmlListProperty to get easy access from QML
	Q_PROPERTY(QQmlListProperty<Conference> conferencesPropertyList READ conferencesPropertyList NOTIFY conferencesPropertyListChanged)

public:
    Speaker(QObject *parent = nullptr);

	Q_INVOKABLE
	bool isAllResolved();

	void fillFromMap(const QVariantMap& speakerMap);
	void fillFromForeignMap(const QVariantMap& speakerMap);
	void fillFromCacheMap(const QVariantMap& speakerMap);
	
	void prepareNew();
	
	bool isValid();

	Q_INVOKABLE
	QVariantMap toMap();
	QVariantMap toForeignMap();
	QVariantMap toCacheMap();

	int speakerId() const;
	void setSpeakerId(int speakerId);
	bool isDeprecated() const;
	void setIsDeprecated(bool isDeprecated);
	QString sortKey() const;
	void setSortKey(QString sortKey);
	QString sortGroup() const;
	void setSortGroup(QString sortGroup);
	QString name() const;
	void setName(QString name);
	QString publicName() const;
	void setPublicName(QString publicName);
	QString title() const;
	void setTitle(QString title);
	QString bio() const;
	void setBio(QString bio);
	// speakerImage lazy pointing to SpeakerImage* (domainKey: speakerId)
	int speakerImage() const;
	void setSpeakerImage(int speakerImage);
	SpeakerImage* speakerImageAsDataObject() const;
	
	Q_INVOKABLE
	void resolveSpeakerImageAsDataObject(SpeakerImage* speakerImage);
	
	Q_INVOKABLE
	void removeSpeakerImage();
	
	Q_INVOKABLE
	bool hasSpeakerImage();
	
	Q_INVOKABLE
	bool isSpeakerImageResolvedAsDataObject();
	
	Q_INVOKABLE
	void markSpeakerImageAsInvalid();
	

	
	Q_INVOKABLE
	QVariantList sessionsAsQVariantList();
	
	Q_INVOKABLE
	QVariantList sessionsAsCacheQVariantList();
	
	Q_INVOKABLE
	QVariantList sessionsAsForeignQVariantList();

	
	Q_INVOKABLE
	void addToSessions(Session* session);
	
	Q_INVOKABLE
	bool removeFromSessions(Session* session);

	Q_INVOKABLE
	void clearSessions();

	// lazy Array of independent Data Objects: only keys are persisted
	Q_INVOKABLE
	bool areSessionsKeysResolved();

	Q_INVOKABLE
	QStringList sessionsKeys();

	Q_INVOKABLE
	void resolveSessionsKeys(QList<Session*> sessions);
	
	Q_INVOKABLE
	int sessionsCount();
	
	 // access from C++ to sessions
	QList<Session*> sessions();
	void setSessions(QList<Session*> sessions);
	// access from QML to sessions
	QQmlListProperty<Session> sessionsPropertyList();
	
	Q_INVOKABLE
	QVariantList conferencesAsQVariantList();
	
	Q_INVOKABLE
	QVariantList conferencesAsCacheQVariantList();
	
	Q_INVOKABLE
	QVariantList conferencesAsForeignQVariantList();

	
	Q_INVOKABLE
	void addToConferences(Conference* conference);
	
	Q_INVOKABLE
	bool removeFromConferences(Conference* conference);

	Q_INVOKABLE
	void clearConferences();

	// lazy Array of independent Data Objects: only keys are persisted
	Q_INVOKABLE
	bool areConferencesKeysResolved();

	Q_INVOKABLE
	QStringList conferencesKeys();

	Q_INVOKABLE
	void resolveConferencesKeys(QList<Conference*> conferences);
	
	Q_INVOKABLE
	int conferencesCount();
	
	 // access from C++ to conferences
	QList<Conference*> conferences();
	void setConferences(QList<Conference*> conferences);
	// access from QML to conferences
	QQmlListProperty<Conference> conferencesPropertyList();


	virtual ~Speaker();

	Q_SIGNALS:

	void speakerIdChanged(int speakerId);
	void isDeprecatedChanged(bool isDeprecated);
	void sortKeyChanged(QString sortKey);
	void sortGroupChanged(QString sortGroup);
	void nameChanged(QString name);
	void publicNameChanged(QString publicName);
	void titleChanged(QString title);
	void bioChanged(QString bio);
	// speakerImage lazy pointing to SpeakerImage* (domainKey: speakerId)
	void speakerImageChanged(int speakerImage);
	void speakerImageAsDataObjectChanged(SpeakerImage* speakerImage);
	void sessionsChanged(QList<Session*> sessions);
	void addedToSessions(Session* session);
	void sessionsPropertyListChanged();
	
	void conferencesChanged(QList<Conference*> conferences);
	void addedToConferences(Conference* conference);
	void conferencesPropertyListChanged();
	
	

private:

	int mSpeakerId;
	bool mIsDeprecated;
	QString mSortKey;
	QString mSortGroup;
	QString mName;
	QString mPublicName;
	QString mTitle;
	QString mBio;
	int mSpeakerImage;
	bool mSpeakerImageInvalid;
	SpeakerImage* mSpeakerImageAsDataObject;
	// lazy Array of independent Data Objects: only keys are persisted
	QStringList mSessionsKeys;
	bool mSessionsKeysResolved;
	QList<Session*> mSessions;
	// implementation for QQmlListProperty to use
	// QML functions for List of Session*
	static void appendToSessionsProperty(QQmlListProperty<Session> *sessionsList,
		Session* session);
	static int sessionsPropertyCount(QQmlListProperty<Session> *sessionsList);
	static Session* atSessionsProperty(QQmlListProperty<Session> *sessionsList, int pos);
	static void clearSessionsProperty(QQmlListProperty<Session> *sessionsList);
	
	// lazy Array of independent Data Objects: only keys are persisted
	QStringList mConferencesKeys;
	bool mConferencesKeysResolved;
	QList<Conference*> mConferences;
	// implementation for QQmlListProperty to use
	// QML functions for List of Conference*
	static void appendToConferencesProperty(QQmlListProperty<Conference> *conferencesList,
		Conference* conference);
	static int conferencesPropertyCount(QQmlListProperty<Conference> *conferencesList);
	static Conference* atConferencesProperty(QQmlListProperty<Conference> *conferencesList, int pos);
	static void clearConferencesProperty(QQmlListProperty<Conference> *conferencesList);
	

	Q_DISABLE_COPY (Speaker)
};
Q_DECLARE_METATYPE(Speaker*)

#endif /* SPEAKER_HPP_ */

