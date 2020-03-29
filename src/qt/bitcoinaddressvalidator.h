// Copyright (c) 2011-2014 The Wazzle Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef WAZZLE_QT_WAZZLEADDRESSVALIDATOR_H
#define WAZZLE_QT_WAZZLEADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class WazzleAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit WazzleAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

/** Wazzle address widget validator, checks for a valid wazzle address.
 */
class WazzleAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit WazzleAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

#endif // WAZZLE_QT_WAZZLEADDRESSVALIDATOR_H
