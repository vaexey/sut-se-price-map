package model


// due to no union/enums in language, ContribStatus = string
type ContribStatus string

type Contrib struct {
    id DbId

    // grouped by
    product DbRef[Product]
    store DbRef[Store]

    author DbRef[User]
    price float32
    date any // todo: define date

    // optional detail view
    comment *string
    attachments []DbRef[Attachment]

    // view status
    status ContribStatus

}

