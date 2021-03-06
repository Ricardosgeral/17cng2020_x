#include "SessionLists.hpp"
#include <QDebug>
#include <quuid.h>

// keys of QVariantMap used in this APP
static const QString uuidKey = "uuid";
static const QString conferenceKey = "conference";
static const QString scheduledSessionsKey = "scheduledSessions";
static const QString sameTimeSessionsKey = "sameTimeSessions";

// keys used from Server API etc
static const QString uuidForeignKey = "uuid";
static const QString conferenceForeignKey = "conference";
static const QString scheduledSessionsForeignKey = "scheduledSessions";
static const QString sameTimeSessionsForeignKey = "sameTimeSessions";

/*
 * Default Constructor if SessionLists not initialized from QVariantMap
 */
SessionLists::SessionLists(QObject *parent) :
        QObject(parent), mUuid(""), mConference(0)
{
		// lazy Arrays where only keys are persisted
		mScheduledSessionsKeysResolved = false;
		mSameTimeSessionsKeysResolved = false;
}

bool SessionLists::isAllResolved()
{
    if(!areScheduledSessionsKeysResolved()) {
        return false;
    }
    if(!areSameTimeSessionsKeysResolved()) {
        return false;
    }
    return true;
}

/*
 * initialize SessionLists from QVariantMap
 * Map got from JsonDataAccess or so
 * includes also transient values
 * uses own property names
 * corresponding export method: toMap()
 */
void SessionLists::fillFromMap(const QVariantMap& sessionListsMap)
{
	mUuid = sessionListsMap.value(uuidKey).toString();
	if (mUuid.isEmpty()) {
		mUuid = QUuid::createUuid().toString();
		mUuid = mUuid.right(mUuid.length() - 1);
		mUuid = mUuid.left(mUuid.length() - 1);
	}	
	mConference = sessionListsMap.value(conferenceKey).toInt();
	// mScheduledSessions is (lazy loaded) Array of Session*
	mScheduledSessionsKeys = sessionListsMap.value(scheduledSessionsKey).toStringList();
	// mScheduledSessions must be resolved later if there are keys
	mScheduledSessionsKeysResolved = (mScheduledSessionsKeys.size() == 0);
	mScheduledSessions.clear();
	// mSameTimeSessions is (lazy loaded) Array of Session*
	mSameTimeSessionsKeys = sessionListsMap.value(sameTimeSessionsKey).toStringList();
	// mSameTimeSessions must be resolved later if there are keys
	mSameTimeSessionsKeysResolved = (mSameTimeSessionsKeys.size() == 0);
	mSameTimeSessions.clear();
}
/*
 * initialize OrderData from QVariantMap
 * Map got from JsonDataAccess or so
 * includes also transient values
 * uses foreign property names - per ex. from Server API
 * corresponding export method: toForeignMap()
 */
void SessionLists::fillFromForeignMap(const QVariantMap& sessionListsMap)
{
	mUuid = sessionListsMap.value(uuidForeignKey).toString();
	if (mUuid.isEmpty()) {
		mUuid = QUuid::createUuid().toString();
		mUuid = mUuid.right(mUuid.length() - 1);
		mUuid = mUuid.left(mUuid.length() - 1);
	}	
	mConference = sessionListsMap.value(conferenceForeignKey).toInt();
	// mScheduledSessions is (lazy loaded) Array of Session*
	mScheduledSessionsKeys = sessionListsMap.value(scheduledSessionsForeignKey).toStringList();
	// mScheduledSessions must be resolved later if there are keys
	mScheduledSessionsKeysResolved = (mScheduledSessionsKeys.size() == 0);
	mScheduledSessions.clear();
	// mSameTimeSessions is (lazy loaded) Array of Session*
	mSameTimeSessionsKeys = sessionListsMap.value(sameTimeSessionsForeignKey).toStringList();
	// mSameTimeSessions must be resolved later if there are keys
	mSameTimeSessionsKeysResolved = (mSameTimeSessionsKeys.size() == 0);
	mSameTimeSessions.clear();
}
/*
 * initialize OrderData from QVariantMap
 * Map got from JsonDataAccess or so
 * excludes transient values
 * uses own property names
 * corresponding export method: toCacheMap()
 */
void SessionLists::fillFromCacheMap(const QVariantMap& sessionListsMap)
{
	mUuid = sessionListsMap.value(uuidKey).toString();
	if (mUuid.isEmpty()) {
		mUuid = QUuid::createUuid().toString();
		mUuid = mUuid.right(mUuid.length() - 1);
		mUuid = mUuid.left(mUuid.length() - 1);
	}	
	mConference = sessionListsMap.value(conferenceKey).toInt();
	// mScheduledSessions is (lazy loaded) Array of Session*
	mScheduledSessionsKeys = sessionListsMap.value(scheduledSessionsKey).toStringList();
	// mScheduledSessions must be resolved later if there are keys
	mScheduledSessionsKeysResolved = (mScheduledSessionsKeys.size() == 0);
	mScheduledSessions.clear();
	// mSameTimeSessions is (lazy loaded) Array of Session*
	mSameTimeSessionsKeys = sessionListsMap.value(sameTimeSessionsKey).toStringList();
	// mSameTimeSessions must be resolved later if there are keys
	mSameTimeSessionsKeysResolved = (mSameTimeSessionsKeys.size() == 0);
	mSameTimeSessions.clear();
}

void SessionLists::prepareNew()
{
	mUuid = QUuid::createUuid().toString();
	mUuid = mUuid.right(mUuid.length() - 1);
	mUuid = mUuid.left(mUuid.length() - 1);
}

/*
 * Checks if all mandatory attributes, all DomainKeys and uuid's are filled
 */
bool SessionLists::isValid()
{
	if (mUuid.isNull() || mUuid.isEmpty()) {
		return false;
	}
	return true;
}
	
/*
 * Exports Properties from SessionLists as QVariantMap
 * exports ALL data including transient properties
 * To store persistent Data in JsonDataAccess use toCacheMap()
 */
QVariantMap SessionLists::toMap()
{
	QVariantMap sessionListsMap;
	// mScheduledSessions points to Session*
	// lazy array: persist only keys
	//
	// if keys alreadyy resolved: clear them
	// otherwise reuse the keys and add objects from mPositions
	// this can happen if added to objects without resolving keys before
	if(mScheduledSessionsKeysResolved) {
		mScheduledSessionsKeys.clear();
	}
	// add objects from mPositions
	for (int i = 0; i < mScheduledSessions.size(); ++i) {
		Session* session;
		session = mScheduledSessions.at(i);
		mScheduledSessionsKeys << QString::number(session->sessionId());
	}
	sessionListsMap.insert(scheduledSessionsKey, mScheduledSessionsKeys);
	// mSameTimeSessions points to Session*
	// lazy array: persist only keys
	//
	// if keys alreadyy resolved: clear them
	// otherwise reuse the keys and add objects from mPositions
	// this can happen if added to objects without resolving keys before
	if(mSameTimeSessionsKeysResolved) {
		mSameTimeSessionsKeys.clear();
	}
	// add objects from mPositions
	for (int i = 0; i < mSameTimeSessions.size(); ++i) {
		Session* session;
		session = mSameTimeSessions.at(i);
		mSameTimeSessionsKeys << QString::number(session->sessionId());
	}
	sessionListsMap.insert(sameTimeSessionsKey, mSameTimeSessionsKeys);
	sessionListsMap.insert(uuidKey, mUuid);
	sessionListsMap.insert(conferenceKey, mConference);
	return sessionListsMap;
}

/*
 * Exports Properties from SessionLists as QVariantMap
 * To send data as payload to Server
 * Makes it possible to use defferent naming conditions
 */
QVariantMap SessionLists::toForeignMap()
{
	QVariantMap sessionListsMap;
	// mScheduledSessions points to Session*
	// lazy array: persist only keys
	//
	// if keys alreadyy resolved: clear them
	// otherwise reuse the keys and add objects from mPositions
	// this can happen if added to objects without resolving keys before
	if(mScheduledSessionsKeysResolved) {
		mScheduledSessionsKeys.clear();
	}
	// add objects from mPositions
	for (int i = 0; i < mScheduledSessions.size(); ++i) {
		Session* session;
		session = mScheduledSessions.at(i);
		mScheduledSessionsKeys << QString::number(session->sessionId());
	}
	sessionListsMap.insert(scheduledSessionsForeignKey, mScheduledSessionsKeys);
	// mSameTimeSessions points to Session*
	// lazy array: persist only keys
	//
	// if keys alreadyy resolved: clear them
	// otherwise reuse the keys and add objects from mPositions
	// this can happen if added to objects without resolving keys before
	if(mSameTimeSessionsKeysResolved) {
		mSameTimeSessionsKeys.clear();
	}
	// add objects from mPositions
	for (int i = 0; i < mSameTimeSessions.size(); ++i) {
		Session* session;
		session = mSameTimeSessions.at(i);
		mSameTimeSessionsKeys << QString::number(session->sessionId());
	}
	sessionListsMap.insert(sameTimeSessionsForeignKey, mSameTimeSessionsKeys);
	sessionListsMap.insert(uuidForeignKey, mUuid);
	sessionListsMap.insert(conferenceForeignKey, mConference);
	return sessionListsMap;
}


/*
 * Exports Properties from SessionLists as QVariantMap
 * transient properties are excluded:
 * To export ALL data use toMap()
 */
QVariantMap SessionLists::toCacheMap()
{
	// no transient properties found from data model
	// use default toMao()
	return toMap();
}
// ATT 
// Mandatory: uuid
// Domain KEY: uuid
QString SessionLists::uuid() const
{
	return mUuid;
}

void SessionLists::setUuid(QString uuid)
{
	if (uuid != mUuid) {
		mUuid = uuid;
		emit uuidChanged(uuid);
	}
}
// ATT 
// Optional: conference
int SessionLists::conference() const
{
	return mConference;
}

void SessionLists::setConference(int conference)
{
	if (conference != mConference) {
		mConference = conference;
		emit conferenceChanged(conference);
	}
}
// ATT 
// Optional: scheduledSessions
QVariantList SessionLists::scheduledSessionsAsQVariantList()
{
	QVariantList scheduledSessionsList;
	for (int i = 0; i < mScheduledSessions.size(); ++i) {
        scheduledSessionsList.append((mScheduledSessions.at(i))->toMap());
    }
	return scheduledSessionsList;
}
QVariantList SessionLists::scheduledSessionsAsCacheQVariantList()
{
	QVariantList scheduledSessionsList;
	for (int i = 0; i < mScheduledSessions.size(); ++i) {
        scheduledSessionsList.append((mScheduledSessions.at(i))->toCacheMap());
    }
	return scheduledSessionsList;
}
QVariantList SessionLists::scheduledSessionsAsForeignQVariantList()
{
	QVariantList scheduledSessionsList;
	for (int i = 0; i < mScheduledSessions.size(); ++i) {
        scheduledSessionsList.append((mScheduledSessions.at(i))->toForeignMap());
    }
	return scheduledSessionsList;
}
// no create() or undoCreate() because dto is root object
// see methods in DataManager
/**
 * you can add scheduledSessions without resolving existing keys before
 * attention: before looping through the objects
 * you must resolveScheduledSessionsKeys
 */
void SessionLists::addToScheduledSessions(Session* session)
{
    mScheduledSessions.append(session);
    emit addedToScheduledSessions(session);
    emit scheduledSessionsPropertyListChanged();
}

bool SessionLists::removeFromScheduledSessions(Session* session)
{
    bool ok = false;
    ok = mScheduledSessions.removeOne(session);
    if (!ok) {
    	qDebug() << "Session* not found in scheduledSessions";
    	return false;
    }
    emit scheduledSessionsPropertyListChanged();
    // scheduledSessions are independent - DON'T delete them
    return true;
}
void SessionLists::clearScheduledSessions()
{
    for (int i = mScheduledSessions.size(); i > 0; --i) {
        removeFromScheduledSessions(mScheduledSessions.last());
    }
    mScheduledSessionsKeys.clear();
}

/**
 * lazy Array of independent Data Objects: only keys are persited
 * so we get a list of keys (uuid or domain keys) from map
 * and we persist only the keys toMap()
 * after initializing the keys must be resolved:
 * - get the list of keys: scheduledSessionsKeys()
 * - resolve them from DataManager
 * - then resolveScheduledSessionsKeys()
 */
bool SessionLists::areScheduledSessionsKeysResolved()
{
    return mScheduledSessionsKeysResolved;
}

QStringList SessionLists::scheduledSessionsKeys()
{
    return mScheduledSessionsKeys;
}

/**
 * Objects from scheduledSessionsKeys will be added to existing scheduledSessions
 * This enables to use addToScheduledSessions() without resolving before
 * Hint: it's your responsibility to resolve before looping thru scheduledSessions
 */
void SessionLists::resolveScheduledSessionsKeys(QList<Session*> scheduledSessions)
{
    if(mScheduledSessionsKeysResolved){
        return;
    }
    // don't clear mScheduledSessions (see above)
    for (int i = 0; i < scheduledSessions.size(); ++i) {
        addToScheduledSessions(scheduledSessions.at(i));
    }
    mScheduledSessionsKeysResolved = true;
}

int SessionLists::scheduledSessionsCount()
{
    return mScheduledSessions.size();
}
QList<Session*> SessionLists::scheduledSessions()
{
	return mScheduledSessions;
}
void SessionLists::setScheduledSessions(QList<Session*> scheduledSessions) 
{
	if (scheduledSessions != mScheduledSessions) {
		mScheduledSessions = scheduledSessions;
		emit scheduledSessionsChanged(scheduledSessions);
		emit scheduledSessionsPropertyListChanged();
	}
}

/**
 * to access lists from QML we're using QQmlListProperty
 * and implement methods to append, count and clear
 * now from QML we can use
 * sessionLists.scheduledSessionsPropertyList.length to get the size
 * sessionLists.scheduledSessionsPropertyList[2] to get Session* at position 2
 * sessionLists.scheduledSessionsPropertyList = [] to clear the list
 * or get easy access to properties like
 * sessionLists.scheduledSessionsPropertyList[2].myPropertyName
 */
QQmlListProperty<Session> SessionLists::scheduledSessionsPropertyList()
{
    return QQmlListProperty<Session>(this, nullptr, &SessionLists::appendToScheduledSessionsProperty,
            &SessionLists::scheduledSessionsPropertyCount, &SessionLists::atScheduledSessionsProperty,
            &SessionLists::clearScheduledSessionsProperty);
}
void SessionLists::appendToScheduledSessionsProperty(QQmlListProperty<Session> *scheduledSessionsList,
        Session* session)
{
    SessionLists *sessionListsObject = qobject_cast<SessionLists *>(scheduledSessionsList->object);
    if (sessionListsObject) {
        sessionListsObject->mScheduledSessions.append(session);
        emit sessionListsObject->addedToScheduledSessions(session);
    } else {
        qWarning() << "cannot append Session* to scheduledSessions " << "Object is not of type SessionLists*";
    }
}
int SessionLists::scheduledSessionsPropertyCount(QQmlListProperty<Session> *scheduledSessionsList)
{
    SessionLists *sessionLists = qobject_cast<SessionLists *>(scheduledSessionsList->object);
    if (sessionLists) {
        return sessionLists->mScheduledSessions.size();
    } else {
        qWarning() << "cannot get size scheduledSessions " << "Object is not of type SessionLists*";
    }
    return 0;
}
Session* SessionLists::atScheduledSessionsProperty(QQmlListProperty<Session> *scheduledSessionsList, int pos)
{
    SessionLists *sessionLists = qobject_cast<SessionLists *>(scheduledSessionsList->object);
    if (sessionLists) {
        if (sessionLists->mScheduledSessions.size() > pos) {
            return sessionLists->mScheduledSessions.at(pos);
        }
        qWarning() << "cannot get Session* at pos " << pos << " size is "
                << sessionLists->mScheduledSessions.size();
    } else {
        qWarning() << "cannot get Session* at pos " << pos << "Object is not of type SessionLists*";
    }
    return nullptr;
}
void SessionLists::clearScheduledSessionsProperty(QQmlListProperty<Session> *scheduledSessionsList)
{
    SessionLists *sessionLists = qobject_cast<SessionLists *>(scheduledSessionsList->object);
    if (sessionLists) {
        // scheduledSessions are independent - DON'T delete them
        sessionLists->mScheduledSessions.clear();
    } else {
        qWarning() << "cannot clear scheduledSessions " << "Object is not of type SessionLists*";
    }
}

// ATT 
// Optional: sameTimeSessions
QVariantList SessionLists::sameTimeSessionsAsQVariantList()
{
	QVariantList sameTimeSessionsList;
	for (int i = 0; i < mSameTimeSessions.size(); ++i) {
        sameTimeSessionsList.append((mSameTimeSessions.at(i))->toMap());
    }
	return sameTimeSessionsList;
}
QVariantList SessionLists::sameTimeSessionsAsCacheQVariantList()
{
	QVariantList sameTimeSessionsList;
	for (int i = 0; i < mSameTimeSessions.size(); ++i) {
        sameTimeSessionsList.append((mSameTimeSessions.at(i))->toCacheMap());
    }
	return sameTimeSessionsList;
}
QVariantList SessionLists::sameTimeSessionsAsForeignQVariantList()
{
	QVariantList sameTimeSessionsList;
	for (int i = 0; i < mSameTimeSessions.size(); ++i) {
        sameTimeSessionsList.append((mSameTimeSessions.at(i))->toForeignMap());
    }
	return sameTimeSessionsList;
}
// no create() or undoCreate() because dto is root object
// see methods in DataManager
/**
 * you can add sameTimeSessions without resolving existing keys before
 * attention: before looping through the objects
 * you must resolveSameTimeSessionsKeys
 */
void SessionLists::addToSameTimeSessions(Session* session)
{
    mSameTimeSessions.append(session);
    emit addedToSameTimeSessions(session);
    emit sameTimeSessionsPropertyListChanged();
}

bool SessionLists::removeFromSameTimeSessions(Session* session)
{
    bool ok = false;
    ok = mSameTimeSessions.removeOne(session);
    if (!ok) {
    	qDebug() << "Session* not found in sameTimeSessions";
    	return false;
    }
    emit sameTimeSessionsPropertyListChanged();
    // sameTimeSessions are independent - DON'T delete them
    return true;
}
void SessionLists::clearSameTimeSessions()
{
    for (int i = mSameTimeSessions.size(); i > 0; --i) {
        removeFromSameTimeSessions(mSameTimeSessions.last());
    }
    mSameTimeSessionsKeys.clear();
}

/**
 * lazy Array of independent Data Objects: only keys are persited
 * so we get a list of keys (uuid or domain keys) from map
 * and we persist only the keys toMap()
 * after initializing the keys must be resolved:
 * - get the list of keys: sameTimeSessionsKeys()
 * - resolve them from DataManager
 * - then resolveSameTimeSessionsKeys()
 */
bool SessionLists::areSameTimeSessionsKeysResolved()
{
    return mSameTimeSessionsKeysResolved;
}

QStringList SessionLists::sameTimeSessionsKeys()
{
    return mSameTimeSessionsKeys;
}

/**
 * Objects from sameTimeSessionsKeys will be added to existing sameTimeSessions
 * This enables to use addToSameTimeSessions() without resolving before
 * Hint: it's your responsibility to resolve before looping thru sameTimeSessions
 */
void SessionLists::resolveSameTimeSessionsKeys(QList<Session*> sameTimeSessions)
{
    if(mSameTimeSessionsKeysResolved){
        return;
    }
    // don't clear mSameTimeSessions (see above)
    for (int i = 0; i < sameTimeSessions.size(); ++i) {
        addToSameTimeSessions(sameTimeSessions.at(i));
    }
    mSameTimeSessionsKeysResolved = true;
}

int SessionLists::sameTimeSessionsCount()
{
    return mSameTimeSessions.size();
}
QList<Session*> SessionLists::sameTimeSessions()
{
	return mSameTimeSessions;
}
void SessionLists::setSameTimeSessions(QList<Session*> sameTimeSessions) 
{
	if (sameTimeSessions != mSameTimeSessions) {
		mSameTimeSessions = sameTimeSessions;
		emit sameTimeSessionsChanged(sameTimeSessions);
		emit sameTimeSessionsPropertyListChanged();
	}
}

/**
 * to access lists from QML we're using QQmlListProperty
 * and implement methods to append, count and clear
 * now from QML we can use
 * sessionLists.sameTimeSessionsPropertyList.length to get the size
 * sessionLists.sameTimeSessionsPropertyList[2] to get Session* at position 2
 * sessionLists.sameTimeSessionsPropertyList = [] to clear the list
 * or get easy access to properties like
 * sessionLists.sameTimeSessionsPropertyList[2].myPropertyName
 */
QQmlListProperty<Session> SessionLists::sameTimeSessionsPropertyList()
{
    return QQmlListProperty<Session>(this, nullptr, &SessionLists::appendToSameTimeSessionsProperty,
            &SessionLists::sameTimeSessionsPropertyCount, &SessionLists::atSameTimeSessionsProperty,
            &SessionLists::clearSameTimeSessionsProperty);
}
void SessionLists::appendToSameTimeSessionsProperty(QQmlListProperty<Session> *sameTimeSessionsList,
        Session* session)
{
    SessionLists *sessionListsObject = qobject_cast<SessionLists *>(sameTimeSessionsList->object);
    if (sessionListsObject) {
        sessionListsObject->mSameTimeSessions.append(session);
        emit sessionListsObject->addedToSameTimeSessions(session);
    } else {
        qWarning() << "cannot append Session* to sameTimeSessions " << "Object is not of type SessionLists*";
    }
}
int SessionLists::sameTimeSessionsPropertyCount(QQmlListProperty<Session> *sameTimeSessionsList)
{
    SessionLists *sessionLists = qobject_cast<SessionLists *>(sameTimeSessionsList->object);
    if (sessionLists) {
        return sessionLists->mSameTimeSessions.size();
    } else {
        qWarning() << "cannot get size sameTimeSessions " << "Object is not of type SessionLists*";
    }
    return 0;
}
Session* SessionLists::atSameTimeSessionsProperty(QQmlListProperty<Session> *sameTimeSessionsList, int pos)
{
    SessionLists *sessionLists = qobject_cast<SessionLists *>(sameTimeSessionsList->object);
    if (sessionLists) {
        if (sessionLists->mSameTimeSessions.size() > pos) {
            return sessionLists->mSameTimeSessions.at(pos);
        }
        qWarning() << "cannot get Session* at pos " << pos << " size is "
                << sessionLists->mSameTimeSessions.size();
    } else {
        qWarning() << "cannot get Session* at pos " << pos << "Object is not of type SessionLists*";
    }
    return nullptr;
}
void SessionLists::clearSameTimeSessionsProperty(QQmlListProperty<Session> *sameTimeSessionsList)
{
    SessionLists *sessionLists = qobject_cast<SessionLists *>(sameTimeSessionsList->object);
    if (sessionLists) {
        // sameTimeSessions are independent - DON'T delete them
        sessionLists->mSameTimeSessions.clear();
    } else {
        qWarning() << "cannot clear sameTimeSessions " << "Object is not of type SessionLists*";
    }
}



SessionLists::~SessionLists()
{
	// place cleanUp code here
}
	
