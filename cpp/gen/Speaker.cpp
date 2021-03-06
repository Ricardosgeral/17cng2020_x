#include "Speaker.hpp"
#include <QDebug>
#include <quuid.h>
// target also references to this
#include "Session.hpp"

// keys of QVariantMap used in this APP
static const QString speakerIdKey = "speakerId";
static const QString isDeprecatedKey = "isDeprecated";
static const QString sortKeyKey = "sortKey";
static const QString sortGroupKey = "sortGroup";
static const QString nameKey = "name";
static const QString publicNameKey = "publicName";
static const QString titleKey = "title";
static const QString bioKey = "bio";
static const QString speakerImageKey = "speakerImage";
static const QString sessionsKey = "sessions";
static const QString conferencesKey = "conferences";

// keys used from Server API etc
static const QString speakerIdForeignKey = "speakerId";
static const QString isDeprecatedForeignKey = "isDeprecated";
static const QString sortKeyForeignKey = "sortKey";
static const QString sortGroupForeignKey = "sortGroup";
static const QString nameForeignKey = "name";
static const QString publicNameForeignKey = "publicName";
static const QString titleForeignKey = "title";
static const QString bioForeignKey = "bio";
static const QString speakerImageForeignKey = "speakerImage";
static const QString sessionsForeignKey = "sessions";
static const QString conferencesForeignKey = "conferences";

/*
 * Default Constructor if Speaker not initialized from QVariantMap
 */
Speaker::Speaker(QObject *parent) :
        QObject(parent), mSpeakerId(-1), mIsDeprecated(false), mSortKey(""), mSortGroup(""), mName(""), mPublicName(""), mTitle(""), mBio("")
{
	// lazy references:
	mSpeakerImage = -1;
    mSpeakerImageAsDataObject = nullptr;
	mSpeakerImageInvalid = false;
		// lazy Arrays where only keys are persisted
		mSessionsKeysResolved = false;
		mConferencesKeysResolved = false;
}

bool Speaker::isAllResolved()
{
	if (hasSpeakerImage() && !isSpeakerImageResolvedAsDataObject()) {
		return false;
	}
    if(!areSessionsKeysResolved()) {
        return false;
    }
    if(!areConferencesKeysResolved()) {
        return false;
    }
    return true;
}

/*
 * initialize Speaker from QVariantMap
 * Map got from JsonDataAccess or so
 * includes also transient values
 * uses own property names
 * corresponding export method: toMap()
 */
void Speaker::fillFromMap(const QVariantMap& speakerMap)
{
	mSpeakerId = speakerMap.value(speakerIdKey).toInt();
	mIsDeprecated = speakerMap.value(isDeprecatedKey).toBool();
	mSortKey = speakerMap.value(sortKeyKey).toString();
	mSortGroup = speakerMap.value(sortGroupKey).toString();
	mName = speakerMap.value(nameKey).toString();
	mPublicName = speakerMap.value(publicNameKey).toString();
	mTitle = speakerMap.value(titleKey).toString();
	mBio = speakerMap.value(bioKey).toString();
	// speakerImage lazy pointing to SpeakerImage* (domainKey: speakerId)
	if (speakerMap.contains(speakerImageKey)) {
		mSpeakerImage = speakerMap.value(speakerImageKey).toInt();
		if (mSpeakerImage != -1) {
			// resolve the corresponding Data Object on demand from DataManager
		}
	}
	// mSessions is (lazy loaded) Array of Session*
	mSessionsKeys = speakerMap.value(sessionsKey).toStringList();
	// mSessions must be resolved later if there are keys
	mSessionsKeysResolved = (mSessionsKeys.size() == 0);
	mSessions.clear();
	// mConferences is (lazy loaded) Array of Conference*
	mConferencesKeys = speakerMap.value(conferencesKey).toStringList();
	// mConferences must be resolved later if there are keys
	mConferencesKeysResolved = (mConferencesKeys.size() == 0);
	mConferences.clear();
}
/*
 * initialize OrderData from QVariantMap
 * Map got from JsonDataAccess or so
 * includes also transient values
 * uses foreign property names - per ex. from Server API
 * corresponding export method: toForeignMap()
 */
void Speaker::fillFromForeignMap(const QVariantMap& speakerMap)
{
	mSpeakerId = speakerMap.value(speakerIdForeignKey).toInt();
	mIsDeprecated = speakerMap.value(isDeprecatedForeignKey).toBool();
	mSortKey = speakerMap.value(sortKeyForeignKey).toString();
	mSortGroup = speakerMap.value(sortGroupForeignKey).toString();
	mName = speakerMap.value(nameForeignKey).toString();
	mPublicName = speakerMap.value(publicNameForeignKey).toString();
	mTitle = speakerMap.value(titleForeignKey).toString();
	mBio = speakerMap.value(bioForeignKey).toString();
	// speakerImage lazy pointing to SpeakerImage* (domainKey: speakerId)
	if (speakerMap.contains(speakerImageForeignKey)) {
		mSpeakerImage = speakerMap.value(speakerImageForeignKey).toInt();
		if (mSpeakerImage != -1) {
			// resolve the corresponding Data Object on demand from DataManager
		}
	}
	// mSessions is (lazy loaded) Array of Session*
	mSessionsKeys = speakerMap.value(sessionsForeignKey).toStringList();
	// mSessions must be resolved later if there are keys
	mSessionsKeysResolved = (mSessionsKeys.size() == 0);
	mSessions.clear();
	// mConferences is (lazy loaded) Array of Conference*
	mConferencesKeys = speakerMap.value(conferencesForeignKey).toStringList();
	// mConferences must be resolved later if there are keys
	mConferencesKeysResolved = (mConferencesKeys.size() == 0);
	mConferences.clear();
}
/*
 * initialize OrderData from QVariantMap
 * Map got from JsonDataAccess or so
 * excludes transient values
 * uses own property names
 * corresponding export method: toCacheMap()
 */
void Speaker::fillFromCacheMap(const QVariantMap& speakerMap)
{
	mSpeakerId = speakerMap.value(speakerIdKey).toInt();
	mIsDeprecated = speakerMap.value(isDeprecatedKey).toBool();
	mSortKey = speakerMap.value(sortKeyKey).toString();
	mSortGroup = speakerMap.value(sortGroupKey).toString();
	mName = speakerMap.value(nameKey).toString();
	mPublicName = speakerMap.value(publicNameKey).toString();
	mTitle = speakerMap.value(titleKey).toString();
	mBio = speakerMap.value(bioKey).toString();
	// speakerImage lazy pointing to SpeakerImage* (domainKey: speakerId)
	if (speakerMap.contains(speakerImageKey)) {
		mSpeakerImage = speakerMap.value(speakerImageKey).toInt();
		if (mSpeakerImage != -1) {
			// resolve the corresponding Data Object on demand from DataManager
		}
	}
	// mSessions is (lazy loaded) Array of Session*
	mSessionsKeys = speakerMap.value(sessionsKey).toStringList();
	// mSessions must be resolved later if there are keys
	mSessionsKeysResolved = (mSessionsKeys.size() == 0);
	mSessions.clear();
	// mConferences is (lazy loaded) Array of Conference*
	mConferencesKeys = speakerMap.value(conferencesKey).toStringList();
	// mConferences must be resolved later if there are keys
	mConferencesKeysResolved = (mConferencesKeys.size() == 0);
	mConferences.clear();
}

void Speaker::prepareNew()
{
}

/*
 * Checks if all mandatory attributes, all DomainKeys and uuid's are filled
 */
bool Speaker::isValid()
{
	if (mSpeakerId == -1) {
		return false;
	}
	return true;
}
	
/*
 * Exports Properties from Speaker as QVariantMap
 * exports ALL data including transient properties
 * To store persistent Data in JsonDataAccess use toCacheMap()
 */
QVariantMap Speaker::toMap()
{
	QVariantMap speakerMap;
	// speakerImage lazy pointing to SpeakerImage* (domainKey: speakerId)
	if (mSpeakerImage != -1) {
		speakerMap.insert(speakerImageKey, mSpeakerImage);
	}
	// mSessions points to Session*
	// lazy array: persist only keys
	//
	// if keys alreadyy resolved: clear them
	// otherwise reuse the keys and add objects from mPositions
	// this can happen if added to objects without resolving keys before
	if(mSessionsKeysResolved) {
		mSessionsKeys.clear();
	}
	// add objects from mPositions
	for (int i = 0; i < mSessions.size(); ++i) {
		Session* session;
		session = mSessions.at(i);
		mSessionsKeys << QString::number(session->sessionId());
	}
	speakerMap.insert(sessionsKey, mSessionsKeys);
	// mConferences points to Conference*
	// lazy array: persist only keys
	//
	// if keys alreadyy resolved: clear them
	// otherwise reuse the keys and add objects from mPositions
	// this can happen if added to objects without resolving keys before
	if(mConferencesKeysResolved) {
		mConferencesKeys.clear();
	}
	// add objects from mPositions
	for (int i = 0; i < mConferences.size(); ++i) {
		Conference* conference;
		conference = mConferences.at(i);
		mConferencesKeys << QString::number(conference->id());
	}
	speakerMap.insert(conferencesKey, mConferencesKeys);
	speakerMap.insert(speakerIdKey, mSpeakerId);
	speakerMap.insert(isDeprecatedKey, mIsDeprecated);
	speakerMap.insert(sortKeyKey, mSortKey);
	speakerMap.insert(sortGroupKey, mSortGroup);
	speakerMap.insert(nameKey, mName);
	speakerMap.insert(publicNameKey, mPublicName);
	speakerMap.insert(titleKey, mTitle);
	speakerMap.insert(bioKey, mBio);
	return speakerMap;
}

/*
 * Exports Properties from Speaker as QVariantMap
 * To send data as payload to Server
 * Makes it possible to use defferent naming conditions
 */
QVariantMap Speaker::toForeignMap()
{
	QVariantMap speakerMap;
	// speakerImage lazy pointing to SpeakerImage* (domainKey: speakerId)
	if (mSpeakerImage != -1) {
		speakerMap.insert(speakerImageForeignKey, mSpeakerImage);
	}
	// mSessions points to Session*
	// lazy array: persist only keys
	//
	// if keys alreadyy resolved: clear them
	// otherwise reuse the keys and add objects from mPositions
	// this can happen if added to objects without resolving keys before
	if(mSessionsKeysResolved) {
		mSessionsKeys.clear();
	}
	// add objects from mPositions
	for (int i = 0; i < mSessions.size(); ++i) {
		Session* session;
		session = mSessions.at(i);
		mSessionsKeys << QString::number(session->sessionId());
	}
	speakerMap.insert(sessionsForeignKey, mSessionsKeys);
	// mConferences points to Conference*
	// lazy array: persist only keys
	//
	// if keys alreadyy resolved: clear them
	// otherwise reuse the keys and add objects from mPositions
	// this can happen if added to objects without resolving keys before
	if(mConferencesKeysResolved) {
		mConferencesKeys.clear();
	}
	// add objects from mPositions
	for (int i = 0; i < mConferences.size(); ++i) {
		Conference* conference;
		conference = mConferences.at(i);
		mConferencesKeys << QString::number(conference->id());
	}
	speakerMap.insert(conferencesForeignKey, mConferencesKeys);
	speakerMap.insert(speakerIdForeignKey, mSpeakerId);
	speakerMap.insert(isDeprecatedForeignKey, mIsDeprecated);
	speakerMap.insert(sortKeyForeignKey, mSortKey);
	speakerMap.insert(sortGroupForeignKey, mSortGroup);
	speakerMap.insert(nameForeignKey, mName);
	speakerMap.insert(publicNameForeignKey, mPublicName);
	speakerMap.insert(titleForeignKey, mTitle);
	speakerMap.insert(bioForeignKey, mBio);
	return speakerMap;
}


/*
 * Exports Properties from Speaker as QVariantMap
 * transient properties are excluded:
 * To export ALL data use toMap()
 */
QVariantMap Speaker::toCacheMap()
{
	// no transient properties found from data model
	// use default toMao()
	return toMap();
}
// REF
// Lazy: speakerImage
// Optional: speakerImage
// speakerImage lazy pointing to SpeakerImage* (domainKey: speakerId)
int Speaker::speakerImage() const
{
	return mSpeakerImage;
}
SpeakerImage* Speaker::speakerImageAsDataObject() const
{
	return mSpeakerImageAsDataObject;
}
void Speaker::setSpeakerImage(int speakerImage)
{
	if (speakerImage != mSpeakerImage) {
        // remove old Data Object if one was resolved
        if (mSpeakerImageAsDataObject) {
            // reset pointer, don't delete the independent object !
            mSpeakerImageAsDataObject = nullptr;
        }
        // set the new lazy reference
        mSpeakerImage = speakerImage;
        mSpeakerImageInvalid = false;
        emit speakerImageChanged(speakerImage);
        if (speakerImage != -1) {
            // resolve the corresponding Data Object on demand from DataManager
        }
    }
}
void Speaker::removeSpeakerImage()
{
	if (mSpeakerImage != -1) {
		setSpeakerImage(-1);
	}
}
bool Speaker::hasSpeakerImage()
{
    if (!mSpeakerImageInvalid && mSpeakerImage != -1) {
        return true;
    } else {
        return false;
    }
}
bool Speaker::isSpeakerImageResolvedAsDataObject()
{
    if (!mSpeakerImageInvalid && mSpeakerImageAsDataObject) {
        return true;
    } else {
        return false;
    }
}

// lazy bound Data Object was resolved. overwrite speakerId if different
void Speaker::resolveSpeakerImageAsDataObject(SpeakerImage* speakerImage)
{
    if (speakerImage) {
        if (speakerImage->speakerId() != mSpeakerImage) {
            setSpeakerImage(speakerImage->speakerId());
        }
        mSpeakerImageAsDataObject = speakerImage;
        mSpeakerImageInvalid = false;
    }
}
void Speaker::markSpeakerImageAsInvalid()
{
    mSpeakerImageInvalid = true;
}
// ATT 
// Mandatory: speakerId
// Domain KEY: speakerId
int Speaker::speakerId() const
{
	return mSpeakerId;
}

void Speaker::setSpeakerId(int speakerId)
{
	if (speakerId != mSpeakerId) {
		mSpeakerId = speakerId;
		emit speakerIdChanged(speakerId);
	}
}
// ATT 
// Optional: isDeprecated
bool Speaker::isDeprecated() const
{
	return mIsDeprecated;
}

void Speaker::setIsDeprecated(bool isDeprecated)
{
	if (isDeprecated != mIsDeprecated) {
		mIsDeprecated = isDeprecated;
		emit isDeprecatedChanged(isDeprecated);
	}
}
// ATT 
// Optional: sortKey
QString Speaker::sortKey() const
{
	return mSortKey;
}

void Speaker::setSortKey(QString sortKey)
{
	if (sortKey != mSortKey) {
		mSortKey = sortKey;
		emit sortKeyChanged(sortKey);
	}
}
// ATT 
// Optional: sortGroup
QString Speaker::sortGroup() const
{
	return mSortGroup;
}

void Speaker::setSortGroup(QString sortGroup)
{
	if (sortGroup != mSortGroup) {
		mSortGroup = sortGroup;
		emit sortGroupChanged(sortGroup);
	}
}
// ATT 
// Optional: name
QString Speaker::name() const
{
	return mName;
}

void Speaker::setName(QString name)
{
	if (name != mName) {
		mName = name;
		emit nameChanged(name);
	}
}
// ATT 
// Optional: publicName
QString Speaker::publicName() const
{
	return mPublicName;
}

void Speaker::setPublicName(QString publicName)
{
	if (publicName != mPublicName) {
		mPublicName = publicName;
		emit publicNameChanged(publicName);
	}
}
// ATT 
// Optional: title
QString Speaker::title() const
{
	return mTitle;
}

void Speaker::setTitle(QString title)
{
	if (title != mTitle) {
		mTitle = title;
		emit titleChanged(title);
	}
}
// ATT 
// Optional: bio
QString Speaker::bio() const
{
	return mBio;
}

void Speaker::setBio(QString bio)
{
	if (bio != mBio) {
		mBio = bio;
		emit bioChanged(bio);
	}
}
// ATT 
// Optional: sessions
QVariantList Speaker::sessionsAsQVariantList()
{
	QVariantList sessionsList;
	for (int i = 0; i < mSessions.size(); ++i) {
        sessionsList.append((mSessions.at(i))->toMap());
    }
	return sessionsList;
}
QVariantList Speaker::sessionsAsCacheQVariantList()
{
	QVariantList sessionsList;
	for (int i = 0; i < mSessions.size(); ++i) {
        sessionsList.append((mSessions.at(i))->toCacheMap());
    }
	return sessionsList;
}
QVariantList Speaker::sessionsAsForeignQVariantList()
{
	QVariantList sessionsList;
	for (int i = 0; i < mSessions.size(); ++i) {
        sessionsList.append((mSessions.at(i))->toForeignMap());
    }
	return sessionsList;
}
// no create() or undoCreate() because dto is root object
// see methods in DataManager
/**
 * you can add sessions without resolving existing keys before
 * attention: before looping through the objects
 * you must resolveSessionsKeys
 */
void Speaker::addToSessions(Session* session)
{
    mSessions.append(session);
    emit addedToSessions(session);
    emit sessionsPropertyListChanged();
}

bool Speaker::removeFromSessions(Session* session)
{
    bool ok = false;
    ok = mSessions.removeOne(session);
    if (!ok) {
    	qDebug() << "Session* not found in sessions";
    	return false;
    }
    emit sessionsPropertyListChanged();
    // sessions are independent - DON'T delete them
    return true;
}
void Speaker::clearSessions()
{
    for (int i = mSessions.size(); i > 0; --i) {
        removeFromSessions(mSessions.last());
    }
    mSessionsKeys.clear();
}

/**
 * lazy Array of independent Data Objects: only keys are persited
 * so we get a list of keys (uuid or domain keys) from map
 * and we persist only the keys toMap()
 * after initializing the keys must be resolved:
 * - get the list of keys: sessionsKeys()
 * - resolve them from DataManager
 * - then resolveSessionsKeys()
 */
bool Speaker::areSessionsKeysResolved()
{
    return mSessionsKeysResolved;
}

QStringList Speaker::sessionsKeys()
{
    return mSessionsKeys;
}

/**
 * Objects from sessionsKeys will be added to existing sessions
 * This enables to use addToSessions() without resolving before
 * Hint: it's your responsibility to resolve before looping thru sessions
 */
void Speaker::resolveSessionsKeys(QList<Session*> sessions)
{
    if(mSessionsKeysResolved){
        return;
    }
    // don't clear mSessions (see above)
    for (int i = 0; i < sessions.size(); ++i) {
        addToSessions(sessions.at(i));
    }
    mSessionsKeysResolved = true;
}

int Speaker::sessionsCount()
{
    return mSessions.size();
}
QList<Session*> Speaker::sessions()
{
	return mSessions;
}
void Speaker::setSessions(QList<Session*> sessions) 
{
	if (sessions != mSessions) {
		mSessions = sessions;
		emit sessionsChanged(sessions);
		emit sessionsPropertyListChanged();
	}
}

/**
 * to access lists from QML we're using QQmlListProperty
 * and implement methods to append, count and clear
 * now from QML we can use
 * speaker.sessionsPropertyList.length to get the size
 * speaker.sessionsPropertyList[2] to get Session* at position 2
 * speaker.sessionsPropertyList = [] to clear the list
 * or get easy access to properties like
 * speaker.sessionsPropertyList[2].myPropertyName
 */
QQmlListProperty<Session> Speaker::sessionsPropertyList()
{
    return QQmlListProperty<Session>(this, nullptr, &Speaker::appendToSessionsProperty,
            &Speaker::sessionsPropertyCount, &Speaker::atSessionsProperty,
            &Speaker::clearSessionsProperty);
}
void Speaker::appendToSessionsProperty(QQmlListProperty<Session> *sessionsList,
        Session* session)
{
    Speaker *speakerObject = qobject_cast<Speaker *>(sessionsList->object);
    if (speakerObject) {
        speakerObject->mSessions.append(session);
        emit speakerObject->addedToSessions(session);
    } else {
        qWarning() << "cannot append Session* to sessions " << "Object is not of type Speaker*";
    }
}
int Speaker::sessionsPropertyCount(QQmlListProperty<Session> *sessionsList)
{
    Speaker *speaker = qobject_cast<Speaker *>(sessionsList->object);
    if (speaker) {
        return speaker->mSessions.size();
    } else {
        qWarning() << "cannot get size sessions " << "Object is not of type Speaker*";
    }
    return 0;
}
Session* Speaker::atSessionsProperty(QQmlListProperty<Session> *sessionsList, int pos)
{
    Speaker *speaker = qobject_cast<Speaker *>(sessionsList->object);
    if (speaker) {
        if (speaker->mSessions.size() > pos) {
            return speaker->mSessions.at(pos);
        }
        qWarning() << "cannot get Session* at pos " << pos << " size is "
                << speaker->mSessions.size();
    } else {
        qWarning() << "cannot get Session* at pos " << pos << "Object is not of type Speaker*";
    }
    return nullptr;
}
void Speaker::clearSessionsProperty(QQmlListProperty<Session> *sessionsList)
{
    Speaker *speaker = qobject_cast<Speaker *>(sessionsList->object);
    if (speaker) {
        // sessions are independent - DON'T delete them
        speaker->mSessions.clear();
    } else {
        qWarning() << "cannot clear sessions " << "Object is not of type Speaker*";
    }
}

// ATT 
// Optional: conferences
QVariantList Speaker::conferencesAsQVariantList()
{
	QVariantList conferencesList;
	for (int i = 0; i < mConferences.size(); ++i) {
        conferencesList.append((mConferences.at(i))->toMap());
    }
	return conferencesList;
}
QVariantList Speaker::conferencesAsCacheQVariantList()
{
	QVariantList conferencesList;
	for (int i = 0; i < mConferences.size(); ++i) {
        conferencesList.append((mConferences.at(i))->toCacheMap());
    }
	return conferencesList;
}
QVariantList Speaker::conferencesAsForeignQVariantList()
{
	QVariantList conferencesList;
	for (int i = 0; i < mConferences.size(); ++i) {
        conferencesList.append((mConferences.at(i))->toForeignMap());
    }
	return conferencesList;
}
// no create() or undoCreate() because dto is root object
// see methods in DataManager
/**
 * you can add conferences without resolving existing keys before
 * attention: before looping through the objects
 * you must resolveConferencesKeys
 */
void Speaker::addToConferences(Conference* conference)
{
    mConferences.append(conference);
    emit addedToConferences(conference);
    emit conferencesPropertyListChanged();
}

bool Speaker::removeFromConferences(Conference* conference)
{
    bool ok = false;
    ok = mConferences.removeOne(conference);
    if (!ok) {
    	qDebug() << "Conference* not found in conferences";
    	return false;
    }
    emit conferencesPropertyListChanged();
    // conferences are independent - DON'T delete them
    return true;
}
void Speaker::clearConferences()
{
    for (int i = mConferences.size(); i > 0; --i) {
        removeFromConferences(mConferences.last());
    }
    mConferencesKeys.clear();
}

/**
 * lazy Array of independent Data Objects: only keys are persited
 * so we get a list of keys (uuid or domain keys) from map
 * and we persist only the keys toMap()
 * after initializing the keys must be resolved:
 * - get the list of keys: conferencesKeys()
 * - resolve them from DataManager
 * - then resolveConferencesKeys()
 */
bool Speaker::areConferencesKeysResolved()
{
    return mConferencesKeysResolved;
}

QStringList Speaker::conferencesKeys()
{
    return mConferencesKeys;
}

/**
 * Objects from conferencesKeys will be added to existing conferences
 * This enables to use addToConferences() without resolving before
 * Hint: it's your responsibility to resolve before looping thru conferences
 */
void Speaker::resolveConferencesKeys(QList<Conference*> conferences)
{
    if(mConferencesKeysResolved){
        return;
    }
    // don't clear mConferences (see above)
    for (int i = 0; i < conferences.size(); ++i) {
        addToConferences(conferences.at(i));
    }
    mConferencesKeysResolved = true;
}

int Speaker::conferencesCount()
{
    return mConferences.size();
}
QList<Conference*> Speaker::conferences()
{
	return mConferences;
}
void Speaker::setConferences(QList<Conference*> conferences) 
{
	if (conferences != mConferences) {
		mConferences = conferences;
		emit conferencesChanged(conferences);
		emit conferencesPropertyListChanged();
	}
}

/**
 * to access lists from QML we're using QQmlListProperty
 * and implement methods to append, count and clear
 * now from QML we can use
 * speaker.conferencesPropertyList.length to get the size
 * speaker.conferencesPropertyList[2] to get Conference* at position 2
 * speaker.conferencesPropertyList = [] to clear the list
 * or get easy access to properties like
 * speaker.conferencesPropertyList[2].myPropertyName
 */
QQmlListProperty<Conference> Speaker::conferencesPropertyList()
{
    return QQmlListProperty<Conference>(this, nullptr, &Speaker::appendToConferencesProperty,
            &Speaker::conferencesPropertyCount, &Speaker::atConferencesProperty,
            &Speaker::clearConferencesProperty);
}
void Speaker::appendToConferencesProperty(QQmlListProperty<Conference> *conferencesList,
        Conference* conference)
{
    Speaker *speakerObject = qobject_cast<Speaker *>(conferencesList->object);
    if (speakerObject) {
        speakerObject->mConferences.append(conference);
        emit speakerObject->addedToConferences(conference);
    } else {
        qWarning() << "cannot append Conference* to conferences " << "Object is not of type Speaker*";
    }
}
int Speaker::conferencesPropertyCount(QQmlListProperty<Conference> *conferencesList)
{
    Speaker *speaker = qobject_cast<Speaker *>(conferencesList->object);
    if (speaker) {
        return speaker->mConferences.size();
    } else {
        qWarning() << "cannot get size conferences " << "Object is not of type Speaker*";
    }
    return 0;
}
Conference* Speaker::atConferencesProperty(QQmlListProperty<Conference> *conferencesList, int pos)
{
    Speaker *speaker = qobject_cast<Speaker *>(conferencesList->object);
    if (speaker) {
        if (speaker->mConferences.size() > pos) {
            return speaker->mConferences.at(pos);
        }
        qWarning() << "cannot get Conference* at pos " << pos << " size is "
                << speaker->mConferences.size();
    } else {
        qWarning() << "cannot get Conference* at pos " << pos << "Object is not of type Speaker*";
    }
    return nullptr;
}
void Speaker::clearConferencesProperty(QQmlListProperty<Conference> *conferencesList)
{
    Speaker *speaker = qobject_cast<Speaker *>(conferencesList->object);
    if (speaker) {
        // conferences are independent - DON'T delete them
        speaker->mConferences.clear();
    } else {
        qWarning() << "cannot clear conferences " << "Object is not of type Speaker*";
    }
}



Speaker::~Speaker()
{
	// place cleanUp code here
}
	
